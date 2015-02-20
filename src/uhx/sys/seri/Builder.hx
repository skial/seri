package uhx.sys.seri;

import haxe.Json;
import haxe.io.Eof;
import sys.io.Process;

using StringTools;
using sys.io.File;
using haxe.io.Path;
using sys.FileSystem;

/**
 * ...
 * @author Skial Bainn
 * ...
 * Usage:
 * 		haxe build.template.hxml
 * 		haxe --macro -cp src -main uhx.sys.seri.Builder
 */
class Builder {
	
	public macro function main() {
		new Builder();
		return macro { };
	}

	public var characters:Int = 0;
	
	public function new() {
		var seri = '${Sys.getCwd()}/bin/seri.n'.normalize();
		var template = '${Sys.getCwd()}/template/Unicode.hx'.normalize();
		var json:Results = { };
		
		if (!seri.exists()) while (!seri.exists()) {
			var process = new Process('haxe', ['build.cmd.hxml']);
			var exitCode = process.exitCode();
			process.close();
			Sys.sleep(0.100);
			
		} else {
			var process = new Process('neko', [seri, '-r', '${Sys.getCwd()}/res/7.0.0/'.normalize(), '-C', '-s', '-b']);
			
			var eofChar = switch (Sys.systemName().toLowerCase()) {
				case 'windows': 26;	//	^Z
				case _: 4; 			//	^D
			}
			
			var content = '';
			var code = -1;
			// For manually or piped text into `stdin` read each byte.
			try while (code != eofChar) {
				code = process.stdout.readByte();
				if (code != eofChar) content += String.fromCharCode( code );
				
			} catch (e:Eof) { 
				
			} catch (e:Dynamic) { 
				
			}
			
			json = Json.parse( content );
			process.close();
			
		}
		
		if (template.exists()) {
			var content = template.getContent();
			var blocks = json.blocks;
			var scripts = json.scripts;
			var categories = json.categories;
			var compiled = content
				.replace("$package", 'v700');
				
			compiled = compiled
				.replace("$version", '7.0.0');
				
			compiled = compiled
				.replace("$blocks", blocks.map( quoted ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t'));
				
			characters = 0;
			compiled = compiled
				.replace("$scripts", scripts.map( quoted ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t'));
				
			characters = 0;
			compiled = compiled
				.replace("$categories", categories.map( quoted ).map( pretty ).join(', ').replace('\n\t\t,', ',\n\t\t'));
			
			if (!'${Sys.getCwd()}/src/uhx/sys/seri/v700/'.normalize().exists()) {
				'${Sys.getCwd()}/src/uhx/sys/seri/v700/'.normalize().createDirectory();
			}
			'${Sys.getCwd()}/src/uhx/sys/seri/v700/Unicode.hx'.normalize().saveContent( compiled );
			
		}
	}
	
	public function quoted(s:String):String {
		return '"$s"';
	}
	
	public function pretty(s:String):String {
		characters += s.length;
		return characters > 50 ? { characters = 0; '$s\n\t\t'; } : '$s';
	}
	
}