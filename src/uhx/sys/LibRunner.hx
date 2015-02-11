package uhx.sys;

import uhx.sys.Seri;
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;

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
	public var classes:Bool = false;
	
	@alias('s')
	public var scripts:Bool = false;
	
	private var unicodeData:String = '';
	private var unicodeParts:Array<String> = [];
	private var unicodeClasses:Array<String> = [];
	private var unicodeScripts:Array<String> = [];
	
	public function new(args:Array<String>) {
		@:cmd _;
		
		load();
		process();
		
		trace( unicodeClasses );
		trace( unicodeScripts );
	}
	
	private function load():Void {
		var dataPath = '$resource/UnicodeData.txt'.normalize();
		
		if (dataPath.exists()) {
			unicodeData = dataPath.getContent();
			unicodeParts = unicodeData.split(';');
			
		}
	}
	
	private function process():Void {
		var length = unicodeParts.length;
		var index = 0;
		
		while (index < length-1) {
			for (i in index...(index + 14)) {
				
				// Builds an array of unicode classes.
				if (classes && (i - index) == 2 && unicodeClasses.indexOf( unicodeParts[i] ) == -1) {
					unicodeClasses.push( unicodeParts[i] );
					
				}
				
				if (scripts && (i - index) == 3 && unicodeScripts.indexOf( unicodeParts[i] ) == -1) {
					unicodeScripts.push( unicodeParts[i] );
					
				}
				
			}
			
			// Move to the next row.
			index += 14;
		}
	}
	
}