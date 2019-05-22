package uhx.sys.seri.builder.ucd;

import uhx.sys.seri.Version;
import uhx.sys.seri.builder.BlockData;

using StringTools;
using tink.CoreApi;
using uhx.sys.seri.builder.Extract;

class Blocks extends Ucd<BlockData> {

    override private function get_output() return 'Block.hx';
    override private function get_name() return 'Blocks';
    override private function get_rangeType() return 'uhx.sys.seri.Range';

    public function new(res:String, ver:Version) {
        super(res, ver);
    }

    public override function map(iter:ResetIterator<BlockData>):Array<Context.Field> {
        var map = new Map();

        for (data in iter) if (data.block != '' && !map.exists(data.block)) {
            map.set( data.block, data.range );
        }
        
        return [for (key in map.keys()) {
            {
                value: key,
                ident: key.identifier(),
                range: map.get(key).printRange(),
            }
        }];
    }

    public override function parse():Promise<ResetIterator<BlockData>> {
        return loadFile()
        .next( c -> {
            (new BlockIterator( 
                new EReg('\n', 'g').split(c)
                .filter( s -> !s.startsWith('#') )
                .map( s -> s.replace('#', ';') )
            ):ResetIterator<BlockData>);
        } );
    }

}