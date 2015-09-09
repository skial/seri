package uhx.sys.seri;

import uhx.sys.Ioe;
import uhx.sys.Seri;
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;
import haxe.Serializer;
import format.gz.Reader;
import haxe.ds.StringMap;

using Lambda;
using StringTools;
using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;
using uhx.sys.seri.LibRunner;

/**
 * ...
 * @author Skial Bainn
 */

@:forward @:enum abstract Information(String) from String to String {
	public var all = 'all';
	public var star = '*';
	public var scripts = 'scripts';
	public var blocks = 'blocks';
	public var categories = 'categories';
}
 
@:usage( 
	'haxelib run seri [options]',
	'haxelib run seri --help',
	'haxelib run seri --categories'
)
@:cmd class LibRunner extends Ioe {

	public static function main() {
		var tool = new LibRunner( Sys.args() );
		tool.exit();
	}
	
	/**
	 * Returns a list of values.
	 */
	@alias('l')
	public var list:Array<Information> = ['*'];
	
	/**
	 * Returns all the code points.
	 */
	@alias('c')
	public var categories:Array<String> = [];
	
	/**
	 * Returns all the unicode scripts.
	 */
	@alias('s')
	public var scripts:Array<String> = [];
	
	/**
	 * Returns all the unicode blocks.
	 */
	@alias('b')
	public var blocks:Array<String> = [];
	
	@alias('v')
	public var version:Version = Seri.version;
	
	/**
	 * The path which stores the Unicode database.
	 */
	@alias('r')
	public var resource:String;
	
	/**
	 * The output format.
	 */
	@alias('f')
	@:isVar public var format(default, set):Format = 'json';
	
		private function set_format(v:String):String {
			return format = v.toLowerCase();
		}
	
	private var _data:String = '';
	private var _blocks:String = '';
	private var _scripts:String = '';
	
	private var dataParts:Array<String> = [];
	private var blockParts:Array<String> = [];
	private var scriptParts:Array<String> = [];
	
	private var unicodeData:Array<UnicodeData> = [];
	private var unicodeBlocks:Array<BlockData> = [];
	private var unicodeScripts:Array<ScriptData> = [];
	private var unicodeCategories:Array<String> = [];
	
	private var characters:Int = 0;
	
	private var response:Response = { codepoints: { } };
	
	private var hasAll:Bool = false;
	private var hasBlock:Bool = false;
	private var hasScript:Bool = false;
	private var hasCategory:Bool = false;
	
	public function new(args:Array<String>) {
		super();
		resource = '${Sys.getCwd()}/res/$version/'.normalize();
		
		@:cmd _;
		
		exitCode = ExitCode.ERRORS;
		
		loadAll();
		setupAll();
		processAll();
		
		exitCode = ExitCode.SUCCESS;
		stdout.writeString( switch (format) {
			case Format.Haxe: buildSerial();
			case Format.Json | _: buildJson();
		} );
	}
	
	private function loadAll():Void {
		loadData();
		loadScripts();
		loadBlocks();
	}
	
	private function loadData():Void {
		dataParts = ( _data = '$resource/UnicodeData.txt.gz'.load().sanitize() ).split( ';' );
	}
	
	private function loadScripts():Void {
		scriptParts = ( _scripts = '$resource/Scripts.txt.gz'.load().sanitize().replace( '#', ';' ) ).split( ';' );
	}
	
	private function loadBlocks():Void {
		blockParts = ( _blocks = '$resource/Blocks.txt.gz'.load().sanitize() ).split( ';' );
	}
	
	private function setupAll():Void {
		hasAll = list.indexOf( Information.all ) > -1 || list.indexOf( Information.star ) > -1;
		hasBlock = list.indexOf( Information.blocks ) > -1;
		hasScript = list.indexOf( Information.scripts ) > -1;
		hasCategory = list.indexOf( Information.categories ) > -1;
		
		if (hasAll || hasBlock) response.blocks = [];
		if (hasAll || hasScript) response.scripts = [];
		if (hasAll || hasCategory) response.categories = [];
		
		if (hasAll || hasBlock || blocks.length > 0) response.codepoints.blocks = { };
		if (hasAll || hasScript || scripts.length > 0) response.codepoints.scripts = { };
		if (hasAll || hasCategory || categories.length > 0) response.codepoints.categories = { };
	}
	
	private function processAll():Void {
		processUnicodeData();
		if (hasAll || hasScript || scripts.length > 0 || categories.length > 0) processScriptData();
		if (hasAll || hasBlock || blocks.length > 0) processBlockData();
		
		ifFor( hasAll || hasCategory || categories.length > 0, categories, categoryPoints );
		ifFor( hasAll || hasScript || scripts.length > 0, scripts, scriptPoints );
		ifFor( hasAll || hasBlock || blocks.length > 0, blocks, blockPoints );
	}
	
	private function processUnicodeData():Void {
		var index = 0;
		var data:UnicodeData;
		var length = dataParts.length;
		
		while (index < length - 1) {
			data = new UnicodeData( dataParts.slice(index, index + 15) );
			unicodeData.push( data );
			
			// Builds an array of unicode classes.
			if ((hasAll || hasCategory) && response.categories.indexOf( data.category ) == -1) {
				response.categories.push( data.category );
				
			}
			
			// Move to the next row.
			index += 15;
		}
	}
	
	private function processScriptData():Void {
		var index = 0;
		var data:ScriptData;
		var length = scriptParts.length;
		
		while (index < length -1) {
			data = new ScriptData( scriptParts.slice(index, index + 4) );
			unicodeScripts.push( data );
			
			// Builds an array of unicode scripts.
			if ((hasAll || hasScript) && response.scripts.indexOf( data.script ) == -1) {
				response.scripts.push( data.script );
				
			}
			
			// Move to the next row.
			index += 3;
		}
	}
	
	private function processBlockData():Void {
		var index = 0;
		var data:BlockData;
		var length = blockParts.length;
		
		while (index < length - 1) {
			data = new BlockData( blockParts.slice(index, index + 2) );
			unicodeBlocks.push( data );
			
			// Builds an array of unicode blocks.
			if ((hasAll || hasBlock) && response.blocks.indexOf( data.block ) == -1) {
				response.blocks.push( data.block );
				
			}
			
			// Move to the next row.
			index += 2;
		}
	}
	
	private function categoryPoints(category:String):Void {
		if (!response.codepoints.categories.exists( category )) {
			
			var results = [];
			var range = new Range( -1, -1 );
			
			for (c in unicodeData) if (c.category == category || (category.length == 1 && c.category.startsWith(category))) {
				if (range.min == -1) range.min = range.max = c.codepoint;
				if ((c.codepoint.toInt() - range.max.toInt()) <= 1) {
					range.max = c.codepoint;
					
				} else {
					results.push( range );
					range = new Range( c.codepoint, c.codepoint );
					
				}
			}
			results.push( range );
			
			response.codepoints.categories.set( category, results );
			
		}
	}
	
	private function scriptPoints(script:String):Void {
		if (!response.codepoints.scripts.exists( script )) {
			
			for (s in unicodeScripts) if (s.script == script) {
				response.codepoints.scripts.set( script, s.range );
				break;
				
			}
			
		}
	}
	
	private function blockPoints(block:String):Void {
		if (!response.codepoints.blocks.exists( block )) {
			
			for (b in unicodeBlocks) if (b.block == block) {
				response.codepoints.blocks.set( block, b.range );
				break;
				
			}
			
		}
	}
	
	private function categoryLength(category:String):Int {
		var range:Range;
		var result = 0;
		
		for (script in unicodeScripts) if (script.category == category) {
			range = script.range;
			
			if (range.min == range.max) {
				result++;
				
			} else {
				result += (range.max:Int) - (range.min:Int)+1;
				
			}
		}
		
		return result;
	}
	
	private function buildJson():String {
		return haxe.Json.stringify( response );
	}
	
	private function buildSerial():String {
		return Serializer.run( response );
	}
	
	private static function load(path:String):String {
		return path.exists() ? loadGzip( path ) : '';
	}
	
	private static function loadGzip(path:String):String {
		var handle = path.read();
		var result = new Reader( handle ).read().data.toString();
		handle.close();
		return result;
	}
	
	private static function sanitize(value:String):String {
		return value.split('\n').filter( hash ).join(';');
	}
	
	private static function hash(s:String) {
		return !s.startsWith('#') && s.trim() != '';
	}
	
	private static function sortCodepoints(a:Int, b:Int):Int {
		return a > b ? 1 : a == b ? 0 : -1;
	}
	
	private static function ifFor<T>(bool:Bool, array:Array<T>, method:T->Void):Void {
		if (bool) for (a in array) method(a);
	}
	
}