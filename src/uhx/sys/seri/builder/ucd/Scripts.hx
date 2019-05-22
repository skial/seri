package uhx.sys.seri.builder.ucd;

import uhx.sys.seri.Version;
import uhx.sys.seri.builder.ScriptData;

using StringTools;
using tink.CoreApi;
using uhx.sys.seri.builder.Extract;

class Scripts extends Ucd<ScriptData> {

    override private function get_output() return 'Script.hx';
    override private function get_name() return 'Scripts';

    public function new(res:String, ver:Version) {
        super(res, ver);
    }

    public override function map(iter:ResetIterator<ScriptData>):Array<Context.Field> {
        var map = new Map<String, Array<Range>>();

        for (data in iter) if (data.script != '') if (!map.exists(data.script)) {
            map.set( data.script, [data.range] );
        } else {
            map.get( data.script ).push( data.range );
        }
        
        return [for (key in map.keys()) {
            {
                value: key,
                ident: key.identifier(),
                range: map.get(key).printRanges(),
            }
        }];
    }

    public override function parse():Promise<ResetIterator<ScriptData>> {
        return loadFile()
        .next( c -> {
            (new ScriptIterator( 
                new EReg('\n', 'g').split(c)
                .filter( s -> !s.startsWith('#') )
                .map( s -> s.replace('#', ';') )
            ):ResetIterator<ScriptData>);
        } );
    }

}