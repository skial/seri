package uhx.sys;

import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;

using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;

/**
 * ...
 * @author Skial Bainn
 * Haitian Creole for range
 */

@:enum abstract UnicodeVersion(String) from String to String {
	public var v700 = '7.0.0';
}
 
class Seri {
	
	/**
	 * The Unicode version the data is base on.
	 */
	public static var version:UnicodeVersion = '7.0.0';

	public function new() {
		
	}
	
}