package uhx.sys;

import uhx.sys.Seri;
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;
import format.gz.Reader;

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
	
	private var _data:String = '';
	private var _scripts:String = '';
	
	private var codepoints:Array<String> = [];
	
	private var dataParts:Array<String> = [];
	private var unicodeScripts:Array<String> = [];
	private var unicodeCategories:Array<String> = [];
	
	public function new(args:Array<String>) {
		@:cmd _;
		
		load();
		process();
		
		trace( unicodeCategories );
		trace( unicodeScripts );
		trace( codepoints );
	}
	
	private function load():Void {
		var dataPath = '$resource/UnicodeData.txt.gz'.normalize();
		var scriptPath = '$resource/Scripts.txt.gz'.normalize();
		
		if (dataPath.exists() && scriptPath.exists()) {
			_data = new Reader( dataPath.read() ).read().data.toString();
			dataParts = _data.split(';');
			
			_scripts = new Reader( scriptPath.read() ).read().data.toString();
			
		}
	}
	
	private function process():Void {
		var length = dataParts.length;
		var index = 0;
		
		while (index < length-1) {
			for (i in index...(index + 14)) {
				
				// Builds an array of unicode classes.
				if (categories && (i - index) == 2 && unicodeCategories.indexOf( dataParts[i] ) == -1) {
					unicodeCategories.push( dataParts[i] );
					
				}
				
				if (scripts && (i - index) == 3 && unicodeScripts.indexOf( dataParts[i] ) == -1) {
					unicodeScripts.push( dataParts[i] );
					
				}
				
				if (category != null && (i - index) == 3 && category == dataParts[i]) {
					codepoints.push( dataParts[i - 3] );
					
				}
				
			}
			
			// Move to the next row.
			index += 14;
		}
	}
	
}