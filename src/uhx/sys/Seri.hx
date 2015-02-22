package uhx.sys;

import haxe.ds.StringMap;
import haxe.Json;
import uhx.sys.seri.*;

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
	#end
	
	public static macro function getCategory(category:ExprOf<String>):ExprOf<Array<CodePoint>> {
		if (category.expr.match(EConst(CString(_)))) {
			// Turn the expression into a string, but remove the quotes. `"Zs"` => `Zs`.
			var value = printer.printExpr( category ).substring(1, 3);
			var results = [];
			
			if (!codepointCache.exists( value )) {
				// Open a new process to seri asking for all codepoints in `value`.
				process = new Process('haxelib', ['run', 'seri', '-c', value]);
				
				// Let the Ioe instance handle the pipes.
				ioe.process( process.stdout, process.stdin );
				var json:Results = Json.parse( ioe.content );
				
				// The return value needs to be an expression.
				results = json.codepoints.map( toExpression );
				
				// And store the expression as its never been fetched before.
				codepointCache.set( value, results );
				
			} else {
				results = codepointCache.get( value );
				
			}
			
			return macro $a { results };
			
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