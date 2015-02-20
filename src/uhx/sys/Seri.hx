package uhx.sys;

import uhx.sys.seri.*;

#if sys
import haxe.io.Input;
import haxe.io.Output;
import sys.FileSystem;
import sys.io.Process;
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
class Seri {
	
	/**
	 * The latest unicode version the data is base on.
	 */
	@:isVar public static var version(get, set):Version = '7.0.0';
	
	#if macro
	private static var printer:Printer = new Printer();
	private static var process:Process;
	#end
	
	public static macro function getCategory(category:ExprOf<String>):ExprOf<Array<CodePoint>> {
		if (category.expr.match(EConst(CString(_)))) {
			//process = new Process('seri', ['-r', 'res/$version/', '-c', printer.printExpr( category )]);
			return macro [];
		} else {
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
	
}