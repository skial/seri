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

private typedef Range = {
	var min:Int;
	var max:Int;
}

private typedef Information = {
	var name:String;
	var category:String;
}

private typedef Group = {> Range, > Information,
	
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
	
	@alias('r')
	public var resource:String;
	
	@alias('c')
	public var category:String;
	
	@alias('k')
	public var categories:Bool = false;
	
	@alias('s')
	public var scripts:Bool = false;
	
	@alias('b')
	public var blocks:Bool = false;
	
	private var _data:String = '';
	private var _blocks:String = '';
	private var _scripts:String = '';
	
	private var blockResults:Array<String> = [];
	private var scriptResults:Array<String> = [];
	private var categoryResults:Array<String> = [];
	private var codepointResults:Array<String> = [];
	
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
		
		trace( categoryResults );
		trace( scriptResults );
		trace( codepointResults );
		trace( blockResults );
	}
	
	private function loadAll():Void {
		loadUnicodeData();
		loadScripts();
		loadBlocks();
	}
	
	private function loadUnicodeData():Void {
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
		if (scripts) processScriptData();
		if (blocks) processBlockData();
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