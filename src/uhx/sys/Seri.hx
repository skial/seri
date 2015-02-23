package uhx.sys;

import haxe.Json;
import uhx.sys.seri.*;
import haxe.ds.StringMap;

#if sys
import uhx.sys.Ioe;
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;
import sys.io.Process;
import uhx.sys.ExitCode;
#end

#if macro
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Printer;
import haxe.macro.Context;
#end

#if sys
using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;
#end

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
	
	#if macro
	private static var ioe:Ioe = new Ioe();
	private static var printer:Printer = new Printer();
	private static var process:Process;
	private static var codepointCache:StringMap<Array<Expr>> = new StringMap();
	public static var requestedCategories:StringMap<Array<String>> = new StringMap();
	#end
	
	public static macro function getCategory(category:ExprOf<String>):ExprOf<Array<CodePoint>> {
		if (category.expr.match(EConst(CString(_)))) {
			// Turn the expression into a string, but remove the quotes. `"Zs"` => `Zs`.
			var value = printer.printExpr( category ).substring(1, 3);
			var results = [];
			
			if (requestedCategories.exists( version )) results = requestedCategories.get( version );
			if (results.indexOf( value ) == -1) results.push( value );
			
			requestedCategories.set( version, results );
			return macro $p { ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode', 'codepoints', 'get'] }( $v{ value } );
			
		} else {
			// If `category` was not a constant string, let the runtime method handle it.
			return macro Seri._getCategory($category);
			
		}
	}
	
	public static function _getCategory(category:String):Array<CodePoint> {
		return [];
	}
	
	private static function get_version():String {
		return version;
	}
	
	private static function set_version(v:String):String {
		return version = v;
	}
	
	#if macro
	public static function toExpression<T>(v:T):Expr return macro $v { v };
	#end
	
}