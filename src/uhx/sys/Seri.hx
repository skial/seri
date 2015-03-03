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
	private static var process:Process;
	private static var ioe:Ioe = new Ioe();
	private static var printer:Printer = new Printer();
	private static var codepointCache:StringMap<Array<Expr>> = new StringMap();
	
	public static var requestedBlocks:StringMap<Array<String>> = new StringMap();
	public static var requestedScripts:StringMap<Array<String>> = new StringMap();
	public static var requestedCategories:StringMap<Array<String>> = new StringMap();
	#end
	
	public static macro function getCategory(category:ExprOf<String>):ExprOf<Array<CodePoint>> {
		var result = macro Seri._getCategory( $category );
		
		if (category.expr.match(EConst(CString(_)))) {
			// Turn the expression into a string, but remove the quotes. `"Zs"` => `Zs`.
			var value = printer.printExpr( category );
			value = value.substring(1, value.length - 1);
			var results = [];
			
			if (requestedCategories.exists( version )) results = requestedCategories.get( version );
			if (results.indexOf( value ) == -1) results.push( value );
			
			requestedCategories.set( version, results );
			
			// Trigger a rebuild of Unicode.hx
			KlasImp.retype( ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode'].join('.'), ':unicode' );
			
			// Bypass `Seri._getCategory`.
			result = macro $p { ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode', 'codePoints', 'get'] }( $v{ value } );
			
		}
		
		return result;
	}
	
	public static function _getCategory(category:String):Array<CodePoint> {
		return uhx.sys.seri.v700.Unicode.codePoints.get(category);
	}
	
	public static macro function getScript(script:ExprOf<String>):ExprOf<Array<CodePoint>> {
		var result = macro Seri._getScript( $script );
		
		if (script.expr.match(EConst(CString(_)))) {
			
			var value = printer.printExpr( script );
			value = value.substring(1, value.length - 1);
			var results = [];
			
			if (requestedScripts.exists( version )) results = requestedScripts.get( version );
			if (results.indexOf( value ) == -1) results.push( value );
			
			requestedScripts.set( version, results );
			
			// Trigger a rebuild of Unicode.hx
			KlasImp.retype( ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode'].join('.'), ':unicode' );
			
			// Bypass `Seri._getScript`.
			result = macro $p { ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode', 'scriptPoints', 'get'] }( $v{ value } );
			
		}
		
		return result;
	}
	
	public static function _getScript(script:String):Array<CodePoint> {
		return uhx.sys.seri.v700.Unicode.scriptPoints.get(script);
	}
	
	public static macro function getBlock(block:ExprOf<String>):ExprOf<Array<CodePoint>> {
		var result = macro Seri._getScript( $block );
		
		if (block.expr.match(EConst(CString(_)))) {
			
			var value = printer.printExpr( block );
			value = value.substring(1, value.length - 1);
			var results = [];
			
			if (requestedBlocks.exists( version )) results = requestedBlocks.get( version );
			if (results.indexOf( value ) == -1) results.push( value );
			
			requestedBlocks.set( version, results );
			
			// Trigger a rebuild of Unicode.hx
			KlasImp.retype( ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode'].join('.'), ':unicode' );
			
			// Bypass `Seri._getBlock`.
			result = macro $p { ['uhx', 'sys', 'seri', 'v${version.replace(".", "")}', 'Unicode', 'blockPoints', 'get'] }( $v{ value } );
			
		}
		
		return result;
	}
	
	public static function _getBlock(block:String):Array<CodePoint> {
		return uhx.sys.seri.v700.Unicode.blockPoints.get(block);
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