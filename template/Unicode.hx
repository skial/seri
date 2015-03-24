package uhx.sys.seri.$package;

import haxe.ds.StringMap;
import uhx.sys.seri.Version;

/**
 * ...
 * @author Skial Bainn
 */
@:unicode("$version")
class Unicode {

	public static var version:Version = "$version";
	public static var blocks:Array<String> = [$blocks];
	public static var scripts:Array<String> = [$scripts];
	public static var categories:Array<String> = [$categories];
	
	@:seri_modify public static var blockPoints:StringMap<Array<CodePoint>> = new StringMap();
	@:seri_modify public static var scriptPoints:StringMap<Array<CodePoint>> = new StringMap();
	@:seri_modify public static var categoryPoints:StringMap<Array<CodePoint>> = new StringMap();
	
}