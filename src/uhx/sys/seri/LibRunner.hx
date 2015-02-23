package uhx.sys.seri;

import haxe.ds.StringMap;
import haxe.Serializer;
import uhx.sys.Seri;
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;
import format.gz.Reader;

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

private typedef Information = {
	var name:String;
	var category:String;
}

private typedef Group = {> Range, > Information,
	
}
 
@:usage( 
	'haxelib run seri [options]',
	'haxelib run seri --help',
	'haxelib run seri --categories'
)
@:cmd class LibRunner implements Klas {

	public static function main() {
		var tool = new LibRunner( Sys.args() );
	}
	
	/**
	 * Returns all the code points for this category.
	 */
	@alias('c')
	public var category:Array<String> = [];
	
	/**
	 * Returns all the unicode categories.
	 */
	@alias('C')
	public var categories:Bool = false;
	
	/**
	 * Returns all the unicode scripts.
	 */
	@alias('s')
	public var scripts:Bool = false;
	
	/**
	 * Returns all the unicode blocks.
	 */
	@alias('b')
	public var blocks:Bool = false;
	
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
	
	private var blockResults:Array<String> = [];
	private var scriptResults:Array<String> = [];
	private var categoryResults:Array<String> = [];
	private var codepointResults:StringMap<Array<Int>> = new StringMap();
	
	private var dataParts:Array<String> = [];
	private var blockParts:Array<String> = [];
	private var scriptParts:Array<String> = [];
	
	private var unicodeData:Array<UnicodeData> = [];
	private var unicodeBlocks:Array<BlockData> = [];
	private var unicodeScripts:Array<ScriptData> = [];
	private var unicodeCategories:Array<String> = [];
	
	private var characters:Int = 0;
	
	public function new(args:Array<String>) {
		resource = '${Sys.getCwd()}/res/$version/'.normalize();
		
		@:cmd _;
		
		loadAll();
		process();
		
		Sys.print( switch (format) {
			case Format.Haxe: buildSerial( buildResult() );
			case Format.Json | _: buildJson( buildResult() );
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
	
	private function process():Void {
		var length = dataParts.length;
		var index = 0;
		
		processUnicodeData();
		if (scripts || category != null) processScriptData();
		if (blocks) processBlockData();
		if (category != null && category.length > 0) for (c in category) categoryCodepoints( c );
	}
	
	private function processUnicodeData():Void {
		var index = 0;
		var data:UnicodeData;
		var length = dataParts.length;
		
		while (index < length - 1) {
			data = dataParts.slice(index, index + 15);
			unicodeData.push( data );
			
			// Builds an array of unicode classes.
			if (categories && categoryResults.indexOf( data.category ) == -1) {
				categoryResults.push( data.category );
				
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
			data = scriptParts.slice(index, index + 4);
			unicodeScripts.push( data );
			
			// Builds an array of unicode scripts.
			if (scriptResults.indexOf( data.script ) == -1) {
				scriptResults.push( data.script );
				
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
			data = blockParts.slice(index, index + 3);
			unicodeBlocks.push( data );
			
			// Builds an array of unicode blocks.
			if (blockResults.indexOf( data.block ) == -1) {
				blockResults.push( data.block );
				
			}
			
			// Move to the next row.
			index += 2;
		}
	}
	
	private function categoryCodepoints(category:String):Void {
		var range:Range;
		var results:Array<Int> = [];
		
		if (!codepointResults.exists( category )) {
		
			for (script in unicodeScripts) if (script.category == category) {
				range = script.range;
				
				if (range.min == range.max) {
					results.push( range.min );
					
				} else for (i in (range.min:Int)...((range.max:Int) + 1)) {
					results.push( i );
					
				}
			}
			
			codepointResults.set( category, results );
			
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
	
	private function buildResult():Results {
		var result:Results = { };
		
		if (categoryResults.length > 0) result.categories = categoryResults;
		if (scripts && scriptResults.length > 0) result.scripts = scriptResults;
		if (blocks && blockResults.length > 0) result.blocks = blockResults;
		if (codepointResults.count() > 0) result.codepoints = [
			for (k in codepointResults.keys()) {
				codepointResults.get( k ).sort( sortCodepoints );
				{ name:k, values:codepointResults.get( k ) };
				
			}
		];
		
		return result;
	}
	
	private function buildJson(v:Results):String {
		var sections = [];
		
		for (section in Reflect.fields(v)) {
			characters = 0;
			
			sections.push( 
				'"$section":[\n\t' + 
				(Reflect.field(v, section):Array<String>).map( printable ).join(', ') + 
				'\n]'
			);
		}
		
		return '{\n' + sections.join( ',\n' ) + '\n}';
	}
	
	private function buildSerial(v:Results):String {
		return Serializer.run( v );
	}
	
	private function printable(s:String):String {
		if (characters <= 35) characters += '$s'.length + 6;
		return (characters > 35? { characters = 0; '\n\t'; } :'') + (Std.is(s, Int)? '$s' : '"$s"');
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
	
}