package uhx.sys.seri;

import haxe.Json;
import uhx.sys.Ioe;
import sys.io.Process;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.ds.StringMap;
import haxe.macro.Printer;
import haxe.macro.Context;
import uhx.sys.seri.Version;
import uhx.sys.seri.CodePoint;

/**
 * ...
 * @author Skial Bainn
 */
class MacroBuilder {

	@:access(uhx.sys.Ioe) public static function build(version:Version):Array<Field> {
		var fields = Context.getBuildFields();
		var requests:StringMap<Array<String>> = Seri.requestedCategories;
		var categories = requests.exists(version) ? requests.get(version) : [];
		
		var ioe:Ioe = new Ioe();
		var process = new Process('haxelib', ['run', 'seri', '-c', categories.join(' ')]);
		ioe.process( process.stdout, process.stdin );
		
		var json:Results = Json.parse( ioe.content );
		var exprs = [for (category in json.codepoints) macro $v { category.name } => $v { category.values } ];
		
		var td:TypeDefinition = macro class TemporarySeriUnicode {
			public static var codepoints:haxe.ds.StringMap<Array<uhx.sys.seri.CodePoint>> = cast [$a{ exprs }];
		}
		
		fields = fields.concat( td.fields );
		
		return fields;
	}
	
}