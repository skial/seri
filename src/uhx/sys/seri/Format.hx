package uhx.sys.seri;

/**
 * ...
 * @author Skial Bainn
 */
@:enum @:forward abstract Format(String) from String to String {
	public var Json = 'json';
	public var Haxe = 'haxe';
}