package uhx.sys.seri;

/**
 * ...
 * @author Skial Bainn
 */
typedef Results = {
	@:optional var categories:Array<String>;
	@:optional var scripts:Array<String>;
	@:optional var blocks:Array<String>;
	@:optional var codepoints:Array<{name:String,values:Array<Int>}>;
}