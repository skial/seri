package uhx.sys.seri.$package;

import uhx.sys.seri.Version;

/**
 * ...
 * @author Skial Bainn
 */
@:autoBuild( uhx.sys.seri.MacroBuilder.build("$version") )
class Unicode {

	public static var version:Version = "$version";
	public static var blocks:Array<String> = [$blocks];
	public static var scripts:Array<String> = [$scripts];
	public static var categories:Array<String> = [$categories];
	
}