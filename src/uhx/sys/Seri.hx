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
import uhx.macro.KlasImp;
import haxe.macro.Printer;
import haxe.macro.Context;
import haxe.macro.Compiler;
#end

#if sys
using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;
#end

#if macro
using haxe.macro.ExprTools;
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
	private static var process:Process;
	private static var ioe:Ioe = new Ioe();
	private static var printer:Printer = new Printer();
	private static var codepointCache:StringMap<Array<Expr>> = new StringMap();
	
	public static var requestedBlocks:StringMap<Array<String>> = new StringMap();
	public static var requestedScripts:StringMap<Array<String>> = new StringMap();
	public static var requestedCategories:StringMap<Array<String>> = new StringMap();
	#end
	
	#if display
	public static function getCategory(category:String):Array<CodePoint> return [];
	#else
	public static macro function getCategory(category:ExprOf<String>):ExprOf<Array<CodePoint>> {
		return processExpr( category, 'Category', requestedCategories );
	}
	
	public static function _getCategory(category:String):Array<CodePoint> {
		return uhx.sys.seri.v700.Unicode.categoryPoints.get(category);
	}
	#end
	
	#if display
	public static function getScript(script:String):Array<CodePoint> return [];
	#else
	public static macro function getScript(script:ExprOf<String>):ExprOf<Array<CodePoint>> {
		return processExpr( script, 'Script', requestedScripts );
	}
	
	public static function _getScript(script:String):Array<CodePoint> {
		return uhx.sys.seri.v700.Unicode.scriptPoints.get(script);
	}
	#end
	
	#if display
	public static function getBlock(block:String):Array<CodePoint> return [];
	#else
	public static macro function getBlock(block:ExprOf<String>):ExprOf<Array<CodePoint>> {
		return processExpr( block, 'Block', requestedBlocks );
	}
	
	public static function _getBlock(block:String):Array<CodePoint> {
		return uhx.sys.seri.v700.Unicode.blockPoints.get(block);
	}
	#end
	
	private static function get_version():String {
		return version;
	}
	
	private static function set_version(v:String):String {
		return version = v;
	}
	
	#if macro
	public static function toExpression<T>(v:T):Expr return macro $v { v };
	
	private static function processExpr(expr:Expr, topic:String, map:StringMap<Array<String>>):Expr {
		var result = macro $p { ['Seri', '_get$topic'] } ( $expr );
		var lVars = Context.getLocalTVars();
		var lMethod = Context.getLocalMethod();
		var lClass = '' + Context.getLocalClass();
		var path = ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode'];
		
		switch (expr.expr) {
			case EConst(CString(value)):
				var results = map.exists( version ) ? map.get( version ) : [];
				if (results.indexOf( value ) == -1) results.push( value );
				
				map.set( version, results );
				
				KlasImp.retype( path.join('.'), ':unicode' );
				
				result = macro $p { path.concat( [ '${topic.toLowerCase()}Points', 'get' ] ) } ($v { value } );
				
			case EConst(CIdent(id)) if (lVars.exists( id )):
				// Look for variable declarations that might contain a constant 
				// string value I can use to populate the Unicode class with.
				KlasImp.inspect( lClass, searchForVariable.bind(_, _, lMethod, id, processExpr.bind(_, topic, map)) );
				
			case _:
				
				
		}
		
		return result;
	}
	
	private static function searchForVariable(type:Type, fields:Array<Field>, field:String, variable:String, callback:Expr->Expr):Void {
		for (_field in fields) if (_field.name == field) switch (_field.kind) {
			case FFun(method) if (method != null): method.expr.iter( matchVariable.bind(_, variable, callback) );
			case _: 
		}
	}
	
	private static function matchVariable(expr:Expr, variable:String, callback:Expr->Expr):Void {
		switch (expr) {
			case macro var $name = $value if (name == variable):
				callback(value);
				
			case _:
				expr.iter( matchVariable.bind(_, variable, callback) );
				
		}
	}
	#end
	
}