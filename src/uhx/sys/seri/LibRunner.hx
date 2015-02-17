package uhx.sys.seri;

import uhx.sys.Seri;
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;
import format.gz.Reader;

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

private typedef Results = {
	@:optional var categories:Array<String>;
	@:optional var scripts:Array<String>;
	@:optional var blocks:Array<String>;
	@:optional var codepoints:Array<Int>;
}
 
@:usage( 
	'seri [options]',
	'seri --help',
	'seri --classes'
)
@:cmd class LibRunner implements Klas {

	public static function main() {
		var tool = new LibRunner( Sys.args() );
	}
	
	@alias('v')
	public var version:UnicodeVersion = '7.0.0';
	
	/**
	 * The path which stores the Unicode database.
	 */
	@alias('r')
	public var resource:String;
	
	/**
	 * Returns all the code points for this category.
	 */
	@alias('c')
	public var category:String;
	
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
	
	private var _data:String = '';
	private var _blocks:String = '';
	private var _scripts:String = '';
	
	private var blockResults:Array<String> = [];
	private var scriptResults:Array<String> = [];
	private var categoryResults:Array<String> = [];
	private var codepointResults:Array<Int> = [];
	
	private var dataParts:Array<String> = [];
	private var blockParts:Array<String> = [];
	private var scriptParts:Array<String> = [];
	
	private var unicodeData:Array<UnicodeData> = [];
	private var unicodeBlocks:Array<BlockData> = [];
	private var unicodeScripts:Array<ScriptData> = [];
	private var unicodeCategories:Array<String> = [];
	
	public function new(args:Array<String>) {
		@:cmd _;
		
		loadAll();
		process();
		
		Sys.print( buildJson( buildResult() ) );
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
		if (category != null && category.trim() != '' && category.length == 2) categoryCodepoints();
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
	
	private function categoryCodepoints():Void {
		var range:Range;
		for (script in unicodeScripts) if (script.category == category) {
			range = script.range;
			
			if (range.min == range.max) {
				codepointResults.push( range.min );
				
			} else for (i in (range.min:Int)...((range.max:Int) + 1)) {
				codepointResults.push( i );
				
			}
		}
	}
	
	private function categoryLength():Int {
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
		
		if (codepointResults.length > 0) {
			codepointResults.sort( function(a, b) return a > b ? 1 : a == b ? 0 : -1 );
			result.codepoints = codepointResults;
			
		}
		
		return result;
	}
	
	private function buildJson(v:Results):String {
		var counter = 0;
		var sections = [];
		
		for (section in Reflect.fields(v)) {
			counter = 0;
			
			sections.push( 
				'"$section":[\n\t' + 
				(Reflect.field(v, section):Array<String>).map( function(s) {
					if (counter <= 35) counter += '$s'.length + 6;
					return (counter > 35? { counter = 0; '\n\t'; } :'') + (Std.is(s, Int)? '$s' : '"$s"');
				} ).join(', ') + 
				'\n]' 
			);
		}
		
		return '{\n' + sections.join( ',\n' ) + '\n}';
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
		return value.split('\n').filter( function(s) return !s.startsWith('#') && s.trim() != '' ).join(';');
	}
	
}