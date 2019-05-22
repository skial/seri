package uhx.sys.seri.builder.ucd;

import uhx.sys.seri.Version;
import uhx.sys.seri.builder.Extract.*;
import uhx.sys.seri.builder.UnicodeData as UCData;

using StringTools;
using tink.CoreApi;
using uhx.sys.seri.builder.Extract;

class UnicodeData extends Ucd<UCData> {

    override private function get_output() return 'Category.hx';
    override private function get_name() return 'UnicodeData';

    public function new(res:String, ver:Version) {
        super(res, ver);
    }
    
    public override function parse():Promise<ResetIterator<UCData>> {
        return loadFile()
        .next( c -> {
            (new DataIterator( new EReg('\n', 'g').split(c) ):ResetIterator<UCData>);
        } );
    }

    public override function map(iter:ResetIterator<UCData>):Array<Context.Field> {
        var categories = [];

        for (data in iter) {
            var single = data.category.charAt(0);

            if (categories.indexOf(single) == -1) {
                categories.push(single);
            }

            if (categories.indexOf(data.category) == -1) {
                categories.push( data.category );
            }
        }

        haxe.ds.ArraySort.sort( categories, @:privateAccess Extract.alphaSort );

        var map = new Map<String, Array<Range>>();

        iter.reset();

        for (category in categories) {
            var ranges = [];
            var range = new Range(-1, -1);

            iter.reset();

            for (data in iter) {
                if (category == data.category || category.length == 1 && data.category.startsWith(category)) {
                    if (range.min == -1) range.min = range.max = data.codepoint;
                    if ((data.codepoint - range.max) <= 1) {
                        range.max = data.codepoint;

                    } else {
                        ranges.push( range );
                        range = new Range( data.codepoint, data.codepoint );
                    }

                }

            }
            ranges.push( range );
            map.set( category, ranges );

        }

        return [for (key in map.keys()) {
            {
                value: key,
                ident: key,
                range: map.get( key ).printRanges(),
            };
        }];
    }

}