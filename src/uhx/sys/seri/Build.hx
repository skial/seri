package uhx.sys.seri;

import haxe.Json;
import haxe.io.Eof;
import haxe.macro.Compiler;
import uhx.sys.Ioe;
import sys.io.Process;
import haxe.macro.Type;
import haxe.macro.Expr;
import uhx.macro.KlasImp;
import haxe.ds.StringMap;
import haxe.macro.Printer;
import haxe.macro.Context;
import uhx.sys.seri.Version;
import uhx.sys.seri.CodePoint;

using StringTools;
using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;

/**
 * ...
 * @author Skial Bainn
 */
@:access(uhx.sys.Ioe) class Build {
	
	private static function initialize() {
		try {
			KlasImp.initalize();
			KlasImp.RETYPE.set( ':unicode', Build.handler );
		} catch (e:Dynamic) {
			// This assumes that `implements Klas` is not being used,
			// which in this case will fail. This macro relies on the 
			// `retype` feature provided by `Klas`.
			throw 'You need to include `-lib klas` in your build file';
		}
	}
	
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
			
			if (!outputPath.exists()) outputPath.createDirectory();
			'$outputPath/Unicode.hx'.normalize().saveContent( compiled );
			
		}
		
		// Something has to be returned :/
		return macro null;
	}
	
	private static var cache = {
		codepoints:new StringMap<Array<CodePoint>>(),
		scriptpoints:new StringMap<Array<CodePoint>>(),
		blockpoints:new StringMap<Array<CodePoint>>(),
	}
	
	public static function handler(cls:ClassType, fields:Array<Field>):Null<TypeDefinition> {
		var td:Null<TypeDefinition> = null;
		var meta = cls.meta.get().filter(function(m) return m.name == ':unicode')[0];
		
		if (meta == null) return null;
		
		var version = quoteless( new Printer().printExprs( meta.params, ' ' ) );
		
		var requests:StringMap<Array<String>> = Seri.requestedCategories;
		var categories = requests.exists(version) ? requests.get(version) : [];
		
		for (key in cache.codepoints.keys()) {
			categories = categories.filter( function(v) return v != key );
		}
		
		if (categories.length > 0) {
			var ioe:Ioe = new Ioe();
			var process = new Process('haxelib', ['run', 'seri', '-c', categories.join(' ')]);
			ioe.process( process.stdout, process.stdin );
			
			var response:Response = Json.parse( ioe.content );
			
			var codepoints = response.codepoints != null ? [for (key in response.codepoints.categories.keys()) macro $v { key } => $v { response.codepoints.categories.get( key ) } ] : [];
			var scriptpoints = response.scripts != null ? [for (key in response.codepoints.scripts.keys()) macro $v { key } => $v { response.codepoints.scripts.get( key ) } ] : [];
			
			fields = fields.filter( function(f) return ['codePoints', 'scriptPoints', 'blockPoints'].indexOf( f.name ) == -1 );
			// Add the cached results.
			for (key in cache.codepoints.keys()) codepoints.push( macro $v { key } => $v { cache.codepoints.get( key ) } );
			for (key in cache.scriptpoints.keys()) codepoints.push( macro $v { key } => $v { cache.scriptpoints.get( key ) } );
			
			td = macro class Fromuhx_sys_seri_Build {
				public static var codePoints:haxe.ds.StringMap<Array<CodePoint>> = cast [$a { codepoints } ];
				public static var scriptPoints:haxe.ds.StringMap<Array<CodePoint>> = cast [$a { scriptpoints } ];
			}
			
			// Set/update the cache results.
			for (key in response.codepoints.categories.keys()) cache.codepoints.set( key, response.codepoints.categories.get( key ) );
			
			process.close();
			
			td.meta = cls.meta.get();
			td.pos = cls.pos;
			td.pack = cls.pack;
			td.name = cls.name;
			td.fields = fields.concat( td.fields );
			
		}
		
		return td;
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
	
}