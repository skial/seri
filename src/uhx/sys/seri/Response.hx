package uhx.sys.seri;

import haxe.DynamicAccess;

/**
 * ...
 * @author Skial Bainn
 */
typedef Response = {
	@:optional var categories:Array<String>;
	@:optional var scripts:Array<String>;
	@:optional var blocks:Array<String>;
	@:optional var codepoints:Points;
}

typedef Points = {
	@:optional var blocks:DynamicAccess<Array<CodePoint>>;
	@:optional var scripts:DynamicAccess<Array<CodePoint>>;
	@:optional var categories:DynamicAccess<Array<CodePoint>>;
}