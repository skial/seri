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
	@:optional var blocks:DynamicAccess<Range>;
	@:optional var scripts:DynamicAccess<Array<Range>>;
	@:optional var categories:DynamicAccess<Array<Range>>;
}