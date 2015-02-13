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
	
	private var codepoints:Array<String> = [];
	
	private var dataParts:Array<String> = [];
	private var blockParts:Array<String> = [];
	private var scriptParts:Array<String> = [];
	
	private var unicodeData:Array<UnicodeData> = [];
	private var unicodeBlocks:Array<String> = [];
	private var unicodeScripts:Array<String> = [];
	private var unicodeCategories:Array<String> = [];
	
	public function new(args:Array<String>) {
		@:cmd _;
		
		loadAll();
		process();
		
		trace( unicodeCategories );
		trace( unicodeScripts );
		trace( codepoints );
		trace( unicodeBlocks );
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
		
		// Scripts.txt
		length = scriptParts.length;
		index = 0;
		
		if (scripts) while (index < length - 1) {
			for (i in index...(index + 3)) {
				if ((i - index) == 1 && unicodeScripts.indexOf( scriptParts[i].trim() ) == -1) {
					unicodeScripts.push( scriptParts[i].trim() );
					
				}
				
			}
			
			// Move to the next row.
			index += 3;
			
		}
		
		// Blocks.txt
		length = blockParts.length;
		index = 0;
		
		if (blocks) while (index < length - 1) {
			for (i in index...(index + 2)) {
				// The second check isnt needed at the time of writing.
				if ((i - index) == 1 && unicodeBlocks.indexOf( blockParts[i].trim() ) == -1) unicodeBlocks.push( blockParts[i].trim() );
				
			}
			
			// Move to the next row.
			index += 2;
			
		}
	}
	
	private function processUnicodeData():Void {
		var index = 0;
		var data:UnicodeData;
		var length = dataParts.length;
		
		while (index < length - 1) {
			data = dataParts.slice(index, index + 15);
			unicodeData.push( data );
			
			// Builds an array of unicode classes.
			if (categories && unicodeCategories.indexOf( data.category ) == -1) {
				unicodeCategories.push( data.category );
				
			}
			
			// Move to the next row.
			index += 15;
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