package uhx.sys.seri.builder;

import asys.*;
import asys.io.*;
import uhx.sys.seri.builder.Defines;
import uhx.sys.seri.builder.ucd.Blocks;
import uhx.sys.seri.builder.ucd.Scripts;
import uhx.sys.seri.builder.ucd.PropList;
import uhx.sys.seri.builder.ucd.Context as Ctx;
import uhx.sys.seri.builder.ucd.UnicodeData as UcdData;
import uhx.sys.seri.Version as UnicodeVersion;

using StringTools;
using haxe.io.Path;
using tink.CoreApi;

typedef TUCD = {
    function context(template:String):Promise<Ctx>;
}

@:nullSafety(Strict) class Extract {

    public static var cwd:String = Sys.getCwd();

    public static var version:UnicodeVersion = Version.defined()
        ? Version.get() : UnicodeVersion.current;

    public static var resource:String = Resource.defined()
        ? Resource.get().normalize() : '$cwd/res/$version/'.normalize();

    public static var datasets:Array<String->Version->TUCD> = [
        UcdData.new.bind(_, _), Blocks.new.bind(_, _), 
        Scripts.new.bind(_, _), PropList.new.bind(_, _)
    ];

    public static function main() {
        if (DryRun) {
            trace( cwd, version );
        }

        if (!Display) Promise.inParallel( 
            datasets.map( d -> d('$cwd/res/', version) )
            .map( d -> d.context('$cwd/template/Abstract.hx') ) 
        )
        .next( build )
        .handle( o -> switch o {
            case Success(_): trace( 'done' );
            case Failure(e): trace( e, e.pos );
        } );
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

    public static function correctCasing(value:String):String {
        return ~/[A-Z]{4,}/g.map( value, (e:EReg) -> {
            var str = e.matched(0);
            str.charAt(0) + str.substr(1).toLowerCase();
        });
    }

    public static function identifier(value:String):String {
        return ~/[ _\\-]/gi
        .split(value)
        .filter( s -> s != '' )
        .map( capitalize )
        .map( correctCasing )
        .join('');
    }

    public static function printRange(r:Range):String {
        return r.length <= 0 ? '${r.min}' : 'new Range(${r.min}, ${r.max})';
    }

    public static function printRanges(v:Array<Range>):String {
        return 'new Ranges([${v.map( printRange ).join(', ')}])';
    }

    public static function build(contexts:Array<Ctx>) {
        var templates = new Map<String, String>();
        var pack = version.replace('.', '');
        var out = '$cwd/src/uhx/sys/seri/v$pack';

        return Promise.inParallel([for (ctx in contexts) {
            if (!templates.exists( ctx.template )) {
                FileSystem.exists( ctx.template )
                .next( b -> b 
                    ? File.getContent(ctx.template).next( str -> new Pair(ctx, str) )
                    : new Error(NotFound, 'Can\t find ${ctx.template}.')
                );

            } else {
                new Pair(ctx, templates.get( ctx.template ));

            }
        }])
        .next( pairs -> {
            pairs.map( pair -> {
                var tpl = new haxe.Template(pair.b);
                new Pair('$out/${pair.a.output}', tpl.execute(pair.a));
            } );
        } )
        .next( pairs -> {
            if (!DryRun && Save) {
                Promise.inParallel([for (pair in pairs) {
                    FileSystem.exists(pair.a.directory())
                    .next( b -> b 
                        ? Promise.NOISE
                        : FileSystem.createDirectory(pair.a.directory())
                    )
                    .next( _ -> File.saveContent(pair.a, pair.b) );
                }])
                .next( _ -> Promise.NOISE );

            } else {
                if (Debug) for (pair in pairs) {
                    trace( pair.b );
                }

                Promise.NOISE;

            }
        });
    }

}