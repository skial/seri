package uhx.sys;

import haxe.Json;
import uhx.sys.seri.*;
import haxe.ds.StringMap;

using StringTools;

/**
 * ...
 * @author Skial Bainn
 * Haitian Creole for range
 */
@:access(uhx.sys.Ioe) class Seri {
	
	/**
	 * The latest unicode version the data is base on.
	 */
	@:isVar public static var version(get, set):Version = '7.0.0';
	
	public static function getCategory(category:String):Array<Range> {
		return uhx.sys.seri.v700.Unicode.categoryPoints.get(category);
	}
	
	public static function getScript(script:String):Array<Range> {
		return uhx.sys.seri.v700.Unicode.scriptPoints.get(script);
	}
	
	public static function getBlock(block:String):Null<Range> {
		return uhx.sys.seri.v700.Unicode.blockPoints.get(block);
	}
	
	private static function get_version():String {
		return version;
	}
	
	private static function set_version(v:String):String {
		return version = v;
	}
	
}