package uhx.sys;

import uhx.sys.Seri;
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;
import format.gz.Reader;

using StringTools;
using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;

/**
 * ...
 * @author Skial Bainn
 */
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
	
	private var unicodeBlocks:Array<String> = [];
	private var unicodeScripts:Array<String> = [];
	private var unicodeCategories:Array<String> = [];
	
	public function new(args:Array<String>) {
		@:cmd _;
		
		load();
		process();
		
		trace( unicodeCategories );
		trace( unicodeScripts );
		trace( codepoints );
		trace( unicodeBlocks );
	}
	
	private function load():Void {
		var blockPath = '$resource/Blocks.txt.gz'.normalize();
		var scriptPath = '$resource/Scripts.txt.gz'.normalize();
		var dataPath = '$resource/UnicodeData.txt.gz'.normalize();
		
		if (dataPath.exists() && scriptPath.exists() && blockPath.exists()) {
			// Easy, seperated by `;`
			_data = new Reader( dataPath.read() ).read().data.toString();
			dataParts = _data.split(';');
			
			// Blocks of text starting with `#`, with lines containing `;` and `#' between info :/
			_scripts = sanitize( new Reader( scriptPath.read() ).read().data.toString() ).replace('#', ';');
			scriptParts = _scripts.split(';');
			
			// Block of text starting with `#', seperated by `;` and `\n`. `\n` is replaced by `;`.
			_blocks = sanitize( new Reader( blockPath.read() ).read().data.toString() );
			blockParts = _blocks.split(';');
		}
	}
	
	private function process():Void {
		var length = dataParts.length;
		var index = 0;
		
		// UnicodeData.txt
		while (index < length - 1) {
			for (i in index...(index + 14)) {
				
				// Builds an array of unicode classes.
				if (categories && (i - index) == 2 && unicodeCategories.indexOf( dataParts[i] ) == -1) {
					unicodeCategories.push( dataParts[i] );
					
				}
				
				if (category != null && (i - index) == 3 && category == dataParts[i]) {
					codepoints.push( dataParts[i - 3] );
					
				}
				
			}
			
			// Move to the next row.
			index += 14;
		}
		
		// Scripts.txt
		length = scriptParts.length;
		index = 0;
		
		if (scripts) while (index < length - 1) {
			for (i in index...(index + 3)) {
				if ((i - index) == 1 && unicodeScripts.indexOf( scriptParts[i].trim() ) == -1) {
					unicodeScripts.push( scriptParts[i].trim() );
					
				}
				
			}
			
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
	
	private function sanitize(value:String):String {
		return value.split('\n').filter( function(s) return !s.startsWith('#') && s.trim() != '' ).join(';');
	}
	
}