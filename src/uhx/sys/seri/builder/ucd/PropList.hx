package uhx.sys.seri.builder.ucd;

import uhx.sys.seri.Version;

using Std;
using StringTools;
using tink.CoreApi;
using uhx.sys.seri.builder.Extract;

@:nullSafety(Strict) class PropList extends Ucd<PropListData> {

    override private function get_name():String return 'PropList';

    public function new(res:String, ver:Version) {
        super(res, ver);
    }

    public override function parse():Promise<ResetIterator<PropListData>> {
        return loadFile()
        .next( c -> {
            (new PropListIterator( 
                new EReg('\n', 'g').split(c)
                .filter( s -> !s.startsWith('#') && s.trim() != '' )
            ):ResetIterator<PropListData>);
        } );
    }

    override public function map(iter:ResetIterator<PropListData>):Array<Context.Field> {
        var map = new Map<String, Array<Range>>();

        for (data in iter) if (!map.exists(data.property)) {
            map.set(data.property, [data.range]);

        } else {
            map.get(data.property).push(data.range);

        }

        return [for (key in map.keys()) {
            {
                value: key,
                ident: key.identifier(),
                range: map.get(key).printRanges(),
            }
        }];
    }

}

@:structInit class PropListIterator {

    public var index:Int = 0;
    private var data:Array<String> = [];

    public inline function new(parts:Array<String>) {
        this.data = parts;
    }

    public function reset():Void {
        index = 0;
    }

    public function hasNext():Bool {
        return index < data.length-1;
    }

    public function next():PropListData {
        index++;
        return PropListData.fromString(data[index]);
    }

}

abstract PropListData(EReg) {

    public static final EREG = new EReg("^([A-Z0-9]+(?:\\.{1,2}[A-Z0-9]+)?)\\s*;\\s*([A-Za-z0-9_]+)\\s*#\\s*([A-Za-z&]{1,2})(\\s+\\[[0-9]+\\]|\\s{2,})([a-zA-Z0-9 \\-\\>\\<\\.]+)$", "gm");

    @:from public inline static function fromString(v:String):PropListData {
        return new PropListData(EREG, v);
    }

    private inline function new(e:EReg, v:String) {
        this = e;
        this.match(v);
    }

    public var range(get, never):Range;
    
    private inline function get_range():Range {
        var str = this.matched(1);
        var parts = str.indexOf('..') > -1 
            ? str.split('..').map( s -> '0x$s'.parseInt() )
            : ['0x$str'.parseInt(), '0x$str'.parseInt()];
        return new Range(parts[0], parts[1]);
    }

    public var property(get, never):String;
    private inline function get_property():String {
        return this.matched(2);
    }

    public var category(get, never):String;
    private inline function get_category():String {
        return this.matched(3);
    }

    public var count(get, never):Int;
    private inline function get_count():Int {
        var str = this.matched(4);
        return str == ''
            ? 0
            : str.substring(1, str.length - 1).parseInt();
    }

    public var identity(get, never):String;
    private inline function get_identity():String {
        return this.matched(5);
    }

}