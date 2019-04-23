package uhx.sys.seri.builder;

import haxe.macro.Context;
import uhx.sys.seri.Version as UnicodeVersion;

using StringTools;
using sys.io.File;
using haxe.io.Path;
using tink.CoreApi;
using sys.FileSystem;

@:nullSafety(Strict) class Extract {

    public static var cwd:String = Sys.getCwd();

    public static var version:UnicodeVersion = Version.defined()
        ? Version.get() : UnicodeVersion.current;

    public static var resource:String = Resource.defined()
        ? Resource.get().normalize() : '$cwd/res/$version/'.normalize();

    public static var dataSrc:Lazy<String> = '$resource/UnicodeData.txt.gz'.normalize();
    public static var scriptSrc:Lazy<String> = '$resource/Scripts.txt.gz'.normalize();
    public static var blockSrc:Lazy<String> = '$resource/Blocks.txt.gz'.normalize();

    public static var dataContent:Lazy<String> = dataSrc.map( p -> decompress(File.read(p)) );
    public static var scriptContent:Lazy<String> = scriptSrc.map( p -> decompress(File.read(p)) );
    public static var blockContent:Lazy<String> = blockSrc.map( p -> decompress(File.read(p)) );

    public static var dataParts:Lazy<Array<String>> = dataContent
        .map( shatter );
    public static var scriptParts:Lazy<Array<String>> = scriptContent
        .map( v -> 
            shatter( v )
            // filter out commented sections.
            .filter( s -> !s.startsWith('#') )
            .map( s -> s.replace('#', ';') 
        ) 
    );
    public static var blockParts:Lazy<Array<String>> = blockContent
        .map( v -> 
            shatter( v )
            // filter out commented sections.
            .filter( s -> !s.startsWith('#') )
            .map( s -> s.replace('#', ';') 
        ) 
    );

    public static function main() {
        processUnicodeData();

        // Add single character categories.
        var singles = [];
        for (category in response.categories) {
            var single = category.charAt(0);

            if (singles.lastIndexOf( single ) == -1) {
                singles.push( single );
            }

        }

        response.categories = singles.concat( response.categories );

        processScriptData();
        processBlockData();

        for (category in response.categories) categoryPoints( category );
        for (script in response.scripts) scriptPoints( script );
        for (block in response.blocks) blockPoints( block );

        build();
    }

    public static var response:Response = { 
        codepoints: {
            scripts: [],
            categories: [],
            blocks: [],
        }, 
        categories: [],
        scripts: [],
        blocks: [],
    }

    public static var unicodeData:Array<UnicodeData> = [];
    public static var scriptData:Array<ScriptData> = [];
    public static var blockData:Array<BlockData> = [];

    public static function processUnicodeData() {
        var parts = new DataIterator(dataParts.get());

        for (data in parts) if (data.codepoint != -1) {
            unicodeData.push( data );

            if (response.categories.indexOf( data.category ) == -1) {
				response.categories.push( data.category );
				
			}

        }

        // Sort `categories` alphabetically
        haxe.ds.ArraySort.sort( response.categories, alphaSort );
    }

    private static function processScriptData() {
        var parts = new ScriptIterator(scriptParts.get());

        for (data in parts) if (data.category != '' && data.script != '') {
            scriptData.push( data );

            if (response.scripts.indexOf( data.script ) == -1) {
				response.scripts.push( data.script );
				
			}

        }
	}

    private static function processBlockData() {
        var parts = new BlockIterator(blockParts.get());

        for (data in parts) if (data.block != '') {
            blockData.push( data );

            if (response.blocks.indexOf( data.block ) == -1) {
				response.blocks.push( data.block );
				
			}

        }
    }

    private static function categoryPoints(category:String):Void {
        var results = [];
        var range = new Range(-1, -1);

        for (c in unicodeData) if (c.category == category || (category.length == 1 && c.category.startsWith(category))) {
            if (range.min == -1) range.min = range.max = c.codepoint;
            if ((c.codepoint.toInt() - range.max.toInt()) <= 1) {
                range.max = c.codepoint;
                
            } else {
                results.push( range );
                range = new Range( c.codepoint, c.codepoint );
                
            }
        }
        results.push( range );
        
        response.codepoints.categories.set( category, results );
    }

    private static function scriptPoints(script:String):Void {
		if (!response.codepoints.scripts.exists( script )) {
			
			var results = [];
			
			for (s in scriptData) {
                if (s.script == script) {
                    
                    results.push( s.range );
                    
                }
            }
			
			response.codepoints.scripts.set( script, results );
			
		}
	}

    private static function blockPoints(block:String):Void {
		if (!response.codepoints.blocks.exists( block )) {
			
			for (b in blockData) if (b.block == block) {
				response.codepoints.blocks.set( block, b.range );
				break;
				
			}
			
		}
	}

    public static function decompress(handle:sys.io.FileInput):String {
        var expanded = new format.gz.Reader( handle ).read().data.toString();
        handle.close();
        return expanded;
    }

    public static function shatter(value:String):Array<String> {
        // Completion would be slow if this wasnt defined.
        var parts = if (Debug.defined() && !Force.defined()) {
            [];
        } else {
            // Eval silently stalls or takes too long to do `value.split(';')`.
            new EReg('\n', 'gi').split(value);
        }

        return parts;
    }

    // Assumes all values are ascii
    private static function alphaSort(a:String, b:String) {
        var aCode = a.charCodeAt(0);
        var bCode = b.charCodeAt(0);
        
        return if (aCode == bCode) {
            if (a.length > 1 && b.length > 1) {
                alphaSort(a.substr(1), b.substr(1));
                
            } else {

                0;
            }

        } else if (aCode > bCode) {
            1;

        } else {
            -1;

        }

    }

    // Assumes all values are ascii.
    public static function capitalize(value:String):String {
        var code = value.fastCodeAt(0);

        code = if (code >= 'a'.code && code <= 'z'.code) {
            code - 32;
        } else {
            code;
        }

        return String.fromCharCode(code) + value.substr(1);
    }

    public static function identifier(value:String):String {
        return ~/[ _\\-]/gi
        .split(value)
        .filter( s -> s != '' )
        .map( capitalize )
        .join('');
    }

    public static function printRange(r:Range):String {
        return 'new Range(${r.min}, ${r.max})';
    }

    public static function printRanges(v:Array<Range>):String {
        return 'new Ranges([${v.map( printRange ).join(', ')}])';
    }

    public static function build() {
        var sets:Array<TemplateCtx> = [];
        var output:Array<{path:String, content:String}> = [];
        var path = '$cwd/template/';

        sets.push( {
            fields:response.blocks.map( function(s) {
                return {
                    value: s,
                    ident: identifier( s ),
                    range: printRange(response.codepoints.blocks.get( s )),
                }
            } ), 
            pack: version.replace('.', ''),
            typeName: 'Block',
            rangeType: 'uhx.sys.seri.Range',
            version: version,
            template:'$path/Abstract.hx'.normalize()
        } );
        sets.push( {
            fields:response.scripts.map( function(s) {
                return {
                    value: s,
                    ident: identifier( s ),
                    range: printRanges( response.codepoints.scripts.get( s ) ),
                }
            } ), 
            pack: version.replace('.', ''),
            typeName: 'Script',
            rangeType: 'uhx.sys.seri.Ranges',
            version: version,
            template:'$path/Abstract.hx'.normalize()
        } );
        sets.push( {
            fields:response.categories.map( function(s) {
                return {
                    value: s,
                    ident: s,
                    range: printRanges( response.codepoints.categories.get( s ) )
                }
            } ), 
            pack: version.replace('.', ''),
            typeName: 'Category',
            rangeType: 'uhx.sys.seri.Ranges',
            version: version,
            template:'$path/Abstract.hx'.normalize()
        } );

        for (set in sets) {
            var template = new haxe.Template(set.template.getContent());
            output.push( { path:'$cwd/src/uhx/sys/seri/v${version.replace(".", "")}/${set.typeName}.hx', content:template.execute( set ) } );

        }
        var template = new haxe.Template('$path/Unicode.hx'.normalize().getContent());
        
        output.push( { path:'$cwd/src/uhx/sys/seri/v${version.replace(".", "")}/Unicode.hx', content: template.execute( {
            version: version,
            pack: version.replace('.', ''),
        } ) } );
        
        if (Force.defined()) {
            for (ctx in output) ctx.path.saveContent( ctx.content );

        }
    }

}

@:forward enum abstract Defines(String) from String to String {

    public var Force = 'force';
    public var Debug = 'debug';
    public var Info = 'seri.info';
    public var Categories = 'seri.categories';
    public var Scripts = 'seri.scripts';
    public var Blocks = 'seri.blocks';
    public var Version = 'seri.version';
    public var Resource = 'seri.resource';
    public var Format = 'seri.format';

    public inline function defined():Bool {
        return Context.defined(this);
    }

    public inline function get():Null<String> {
        return Context.definedValue(this);
    }

}

typedef TemplateCtx = {
    fields:Array<{
        value:String, 
        ident:String, 
        range:String,
    }>,
    pack:String,
    typeName:String,
    rangeType:String,
    version:String,
    template:String,
}