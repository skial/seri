package uhx.sys.seri;

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
			KlasImp.CLASS_META.set( ':unicode', Build.handler );
		} catch (e:Dynamic) {
			// This assumes that `implements Klas` is not being used
			// but `@:autoBuild` or `@:build` metadata is being used 
			// with the provided `uhx.sys.seri.Build.build()` method.
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
	
	public static function quoted(s:String):String {
		return '"$s"';
	}
	
	public static function pretty(s:String):String {
		characters += s.length;
		return characters > 50 ? { characters = 0; '$s\n\t\t'; } : '$s';
	}
	
	public static function build():Array<Field> {
        return handler(  Context.getLocalClass().get(), Context.getBuildFields() );
	}
	
	public static function handler(cls:ClassType, fields:Array<Field>):Array<Field> {
		var meta = cls.meta.get().filter(function(m) return m.name == ':unicode')[0];
		
		// Break early.
		if (meta == null) return fields;
		
		var version = new Printer().printExprs( meta.params, ' ' );
		version = version.substring(1, version.length - 1);
		
		var requests:StringMap<Array<String>> = Seri.requestedCategories;
		var categories = requests.exists(version) ? requests.get(version) : [];
		trace( requests );
		var ioe:Ioe = new Ioe();
		var process = new Process('haxelib', ['run', 'seri', '-c', categories.join(' ')]);
		ioe.process( process.stdout, process.stdin );
		
		var response:Response = Json.parse( ioe.content );
		
		var codepoints = response.codepoints != null ? [for (key in response.codepoints.categories.keys()) macro $v { key } => $v { response.codepoints.categories.get( key ) } ] : [];
		var scriptpoints = response.scripts != null ? [for (key in response.codepoints.scripts.keys()) macro $v { key } => $v { response.codepoints.scripts.get( key ) } ] : [];
		
		var td:TypeDefinition = macro class TemporarySeriUnicode {
			public static var codePoints:haxe.ds.StringMap<Array<CodePoint>> = cast [$a { codepoints } ];
			public static var scriptPoints:haxe.ds.StringMap<Array<CodePoint>> = cast [$a { scriptpoints } ];
		}
		
		process.close();
		fields = fields.concat( td.fields );
		
		return fields;
	}
	
}