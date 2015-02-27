package uhx.sys.seri.$package;

import haxe.ds.StringMap;
import uhx.sys.seri.Version;

/**
 * ...
 * @author Skial Bainn
 */
@:unicode("$version")
class Unicode implements Klas {

	public static var version:Version = "$version";
	public static var blocks:Array<String> = [$blocks];
	public static var scripts:Array<String> = [$scripts];
	public static var categories:Array<String> = [$categories];
	
	public static var codePoints:StringMap<Array<CodePoint>> = new StringMap();
	public static var blockPoints:StringMap<Array<CodePoint>> = new StringMap();
	public static var scriptPoints:StringMap<Array<CodePoint>> = new StringMap();
	
}