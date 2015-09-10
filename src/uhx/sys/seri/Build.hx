package uhx.sys.seri;

import haxe.Json;
import haxe.io.Eof;
import uhx.sys.Ioe;
import sys.io.Process;
import haxe.macro.Type;
import haxe.macro.Expr;
import uhx.macro.KlasImp;
import haxe.ds.StringMap;
import haxe.DynamicAccess;
import haxe.macro.Printer;
import haxe.macro.Context;
import haxe.macro.Compiler;
import uhx.sys.seri.Version;
import haxe.Constraints.IMap;
import uhx.sys.seri.CodePoint;

using Lambda;
using StringTools;
using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;
using haxe.macro.MacroStringTools;

/**
 * ...
 * @author Skial Bainn
 */
@:access(uhx.sys.Ioe) class Build {
	
	public static var characters:Int = 0;
	
	/**
	 *  Usage:
	 *		haxe build.template.hxml
	 *		haxe -lib cmd -lib unifill -cp src --macro uhx.sys.seri.Build.template()
	 */
	public static function template() {
		var ioe = new Ioe();
		var response:Response = { };
		var templatePath = '${Sys.getCwd()}/template/Unicode.hx'.normalize();
		var outputPath = '${Sys.getCwd()}/src/uhx/sys/Seri/v700/'.normalize();
		var process = new Process('haxelib', ['run', 'seri', '-r', '${Sys.getCwd()}/res/7.0.0/'.normalize(), '-l', '*']);
		
		ioe.process( process.stdout, process.stdin );
		response = Json.parse( ioe.content );
		process.close();
		
		if (templatePath.exists()) {
			var content = templatePath.getContent();
			var compiled = content
				.replace("$package", 'v700');
				
			compiled = compiled
				.replace("$version", '7.0.0');
				
			compiled = compiled
				.replace("$blocks", response.blocks.map( quoted ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t'));
				
			characters = 0;
			compiled = compiled
				.replace("$scripts", response.scripts.map( quoted ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t'));
				
			characters = 0;
			compiled = compiled
				.replace("$categories", response.categories.map( quoted ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t'));
				
			var blockPoints = [];
			var scriptPoints = [];
			var categoryPoints = [];
			var cmd = new Process('haxelib', 
				['run', 'seri', '-r', '${Sys.getCwd()}/res/7.0.0/'.normalize(), 
				'-l', '_', '-b'].concat( response.blocks )
				.concat( ['-s'].concat( response.scripts ) )
				.concat( ['-c'].concat( response.categories ) ) 
			);
			
			ioe = new Ioe();
			ioe.process( cmd.stdout, cmd.stdin );
			var reply:Response = Json.parse( ioe.content );
			
			for (block in response.blocks) {
				var range = reply.codepoints.blocks.get( block );
				if (range != null) {
					blockPoints.push( '"$block" => new Range(${range.min.toInt()}, ${range.max.toInt()})' );
				}
			}
			
			for (script in response.scripts) {
				var ranges = reply.codepoints.scripts.get( script );
				scriptPoints.push( '"$script" => new Ranges(['
				+ ranges.map( function(r) return 'new Range(${r.min.toInt()}, ${r.max.toInt()})' ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t')
				+ '])' );
			}
			
			characters = 0;
			for (category in response.categories) {
				var ranges = reply.codepoints.categories.get( category );
				categoryPoints.push( '"$category" => new Ranges([' 
				+ ranges.map( function(r) return 'new Range(${r.min.toInt()}, ${r.max.toInt()})' ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t')
				+ '])' );
			}
			
			response.blocks = response.scripts = response.categories = null;
			response.blocks = response.scripts = response.categories = [];
			
			characters = 0;
			compiled = compiled
				.replace("$blockPoints", '[' + blockPoints.map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t') + ']');
				
			characters = 0;
			compiled = compiled
				.replace("$scriptPoints", '[' + scriptPoints.map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t') + ']');
				
			characters = 0;
			compiled = compiled
				.replace("$categoryPoints", '[' + categoryPoints.map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t') + ']');
			
			if (!outputPath.exists()) outputPath.createDirectory();
			'$outputPath/Unicode.hx'.normalize().saveContent( compiled );
			
		}
		
		// Something has to be returned :/
		return macro null;
	}
	
	public static function quoteless(v:String):String {
		return v.substring(1, v.length - 1);
	}
	
	public static function quoted(s:String):String {
		return '"$s"';
	}
	
	public static function pretty(s:String):String {
		characters += s.length;
		return characters > 50 ? { characters = 0; '$s\n\t\t'; } : '$s';
	}
	
	private static inline function toCodePointExpr(value:CodePoint):ExprOf<CodePoint> {
		return macro uhx.sys.seri.CodePoint.fromInt($v { value.toInt() } );
	}
	
}