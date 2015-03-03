package uhx.sys.seri;

import haxe.Constraints.IMap;
import haxe.DynamicAccess;
import haxe.Json;
import haxe.io.Eof;
import uhx.sys.Ioe;
import sys.io.Process;
import haxe.macro.Type;
import haxe.macro.Expr;
import uhx.macro.KlasImp;
import haxe.ds.StringMap;
import haxe.macro.Printer;
import haxe.macro.Context;
import haxe.macro.Compiler;
import uhx.sys.seri.Version;
import uhx.sys.seri.CodePoint;

using Lambda;
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
			KlasImp.initialize();
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
		var argF = function(v:String, k:String):Bool return v != k;
		var meta = cls.meta.get().filter(function(m) return m.name == ':unicode')[0];
		
		if (meta == null) return null;
		
		var version = quoteless( new Printer().printExprs( meta.params, ' ' ) );
		var requests = { categories: Seri.requestedCategories, scripts: Seri.requestedScripts, blocks: Seri.requestedBlocks }
		var categories = requests.categories.exists(version) ? requests.categories.get(version) : [];
		var scripts = requests.scripts.exists(version) ? requests.scripts.get(version) : [];
		var blocks = requests.blocks.exists(version) ? requests.blocks.get(version) : [];
		
		for (key in cache.codepoints.keys()) categories = categories.filter( argF.bind(_, key) );
		for (key in cache.scriptpoints.keys()) scripts = scripts.filter( argF.bind(_, key) );
		for (key in cache.blockpoints.keys()) blocks = blocks.filter( argF.bind(_, key) );
		
		if (categories.length > 0 || scripts.length > 0 || blocks.length > 0) {
			var ioe = new Ioe();
			var codepoints = [];
			var scriptpoints = [];
			var blockpoints = [];
			var response:Response = { };
			var stype = macro :Array<CodePoint>;
			var type = macro :haxe.ds.StringMap<$stype>;
			var _default = macro new haxe.ds.StringMap<$stype>();
			var arguments = ['run', 'seri', '-l', '_'];
			if (categories.length > 0) arguments = arguments.concat( ['-c', categories.join(' ')] );
			if (scripts.length > 0) arguments = arguments.concat( ['-s', scripts.join(' ')] );
			if (blocks.length > 0) arguments = arguments.concat( ['-b', blocks.join(' ')] );
			var process = new Process('haxelib', arguments);
			
			ioe.process( process.stdout, process.stdin );
			response = Json.parse( ioe.content );
			trace( ioe.content );
			if (response.codepoints != null) {
				codepoints = [for (key in response.codepoints.categories.keys()) macro $v { key }=> $v { response.codepoints.categories.get(key) } ];
				scriptpoints = [for (key in response.codepoints.scripts.keys()) macro $v { key }=> $v { response.codepoints.scripts.get(key) } ];
				blockpoints = [for (key in response.codepoints.blocks.keys()) macro $v { key }=> $v { response.codepoints.blocks.get(key) } ];
				
			}
			
			// Filter out fields with `@:seri_modify` metadata.
			fields = fields.filter( function(f) return f.meta == null ? true : !f.meta.exists( function(m) return m.name == ':seri_modify' ) );
			
			// Add the cached results.
			for (key in cache.codepoints.keys()) codepoints.push( macro $v { key } => $v { cache.codepoints.get( key ) } );
			for (key in cache.scriptpoints.keys()) scriptpoints.push( macro $v { key } => $v { cache.scriptpoints.get( key ) } );
			for (key in cache.blockpoints.keys()) blockpoints.push( macro $v { key } => $v { cache.blockpoints.get( key ) } );
			
			// The reason for casting is that StringMap and Map are not unifing.
			// If typed as `Map<String, $stype>`, then the map comprehension
			// generates insane output, which the analyser doesnt currently fix.
			td = macro class Fromuhx_sys_seri_Build {
				@:seri_modify public static var codePoints:$type = $e { codepoints.length > 0 ? macro cast $a { codepoints } : _default };
				@:seri_modify public static var scriptPoints:$type = $e { scriptpoints.length > 0 ? macro cast $a { scriptpoints } : _default };
				@:seri_modify public static var blockPoints:$type = $e { blockpoints.length > 0 ? macro cast $a { blockpoints } : _default };
			}
			
			// Set/update the cache results.
			for (key in response.codepoints.categories.keys()) cache.codepoints.set( key, response.codepoints.categories.get( key ) );
			for (key in response.codepoints.scripts.keys()) cache.scriptpoints.set( key, response.codepoints.scripts.get( key ) );
			for (key in response.codepoints.blocks.keys()) cache.blockpoints.set( key, response.codepoints.blocks.get( key ) );
			
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