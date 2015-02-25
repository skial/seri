package uhx.sys.seri;

import haxe.Json;
import haxe.io.Eof;
import uhx.sys.Ioe;
import sys.io.Process;
import haxe.macro.Type;
import haxe.macro.Expr;
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
	
	public static function macros(version:Version):Array<Field> {
		var fields = Context.getBuildFields();
		var requests:StringMap<Array<String>> = Seri.requestedCategories;
		var categories = requests.exists(version) ? requests.get(version) : [];
		
		var ioe:Ioe = new Ioe();
		var process = new Process('haxelib', ['run', 'seri', '-c', categories.join(' ')]);
		ioe.process( process.stdout, process.stdin );
		
		var json:Response = Json.parse( ioe.content );
		var codepoints = json.codepoints != null ? [for (key in json.codepoints.categories.keys()) macro $v { key } => $v { json.codepoints.categories.get( key ) } ] : [];
		var scriptpoints = json.scripts != null ? [for (script in json.scripts) macro $v { [] } ] : [];
		
		var td:TypeDefinition = macro class TemporarySeriUnicode {
			public static var codePoints:haxe.ds.StringMap<Array<CodePoint>> = cast [$a { codepoints } ];
			public static var scriptPoints:haxe.ds.StringMap<Array<CodePoint>> = cast [$a { scriptpoints } ];
		}
		
		process.close();
		fields = fields.concat( td.fields );
		
		return fields;
	}
	
}