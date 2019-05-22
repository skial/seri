package uhx.sys.seri.builder.ucd;

import asys.io.File;
import asys.FileSystem;
import asys.io.FileInput;
import uhx.sys.seri.Version;

using StringTools;
using haxe.io.Path;
using tink.CoreApi;

class Ucd<Data> {

    private var res:String = '';
    private var ver:Version = Version.current;

    public var name(get, null):String;
    public var file(get, null):String;
    public var gzip(get, null):String;
    public var output(get, null):String;

    private var rangeType(get, null):String;
    private function get_rangeType():String return 'uhx.sys.seri.Ranges';
    private function get_name():String throw 'Not implemented';
    private function get_file():String return '$name.txt';
    private function get_gzip():String return '$file.gz';
    private function get_output():String return '$name.hx';

    public function new(resourceDirectory:String, version:Version) {
        res = resourceDirectory;
        ver = version;
    }

    public function context(template:String):Promise<Context> {
        return parse()
        .next( iter -> {
            var fields = map(iter);
            haxe.ds.ArraySort.sort( 
                fields, 
                (a, b) -> @:privateAccess Extract.alphaSort(a.ident, b.ident) 
            );
            {
                fields: fields,
                pack: ver.replace('.', ''),
                typeName: output.withoutExtension(),
                rangeType: rangeType,
                version: ver,
                template: template,
                output: output,
            }
        } );
    }

    public function map(data:ResetIterator<Data>):Array<Context.Field> {
        return throw 'Not implemented';
    }

    public function parse():Promise<ResetIterator<Data>> {
        return throw 'Not implemented';
    }

    public function loadFile():Promise<String> {
        return FileSystem.exists('$res/$ver/$file')
        .next( b -> b 
            ? File.getContent('$res/$ver/$file') : loadGZip()
        );
    }

    public function loadGZip():Promise<String> {
        return FileSystem.exists('$res/$gzip')
        .next( b -> b 
            ? new Error(NotFound, 'Can\'t find $res/$ver/$gzip.')
            : File.read('$res/$ver/$gzip')
        )
        .next( decompress )
        .next( content -> {
            File.saveContent('$res/$ver/$file', content)
            .next( _ -> content );
        } );
    }

    public function decompress(handle:FileInput):Promise<String> {
        return Error.catchExceptions( () -> {
            var expanded = new format.gz.Reader( handle ).read().data.toString();
            handle.close();
            expanded;
        } );
    }

}