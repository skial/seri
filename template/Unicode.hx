package uhx.sys.seri.$package;

import haxe.ds.StringMap;
import uhx.sys.seri.Range as S;
import uhx.sys.seri.Ranges as A;
import uhx.sys.seri.Version;

/**
 * ...
 * @author Skial Bainn
 */
@:unicode("$version")
class Unicode {

	public static var version:Version = "$version";
	
	public static var blocks:Array<String> = [
		$blocks
	];
	
	public static var scripts:Array<String> = [
		$scripts
	];
	
	public static var categories:Array<String> = [
		$categories
	];
	
	public static var blockPoints:StringMap<Range> = $blockPoints;
	
	public static var scriptPoints:StringMap<Ranges> = $scriptPoints;
	
	public static var categoryPoints:StringMap<Ranges> = $categoryPoints;
	
}