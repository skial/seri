package uhx.sys.seri.builder.ucd;

import uhx.sys.seri.Version;

using Std;
using StringTools;
using tink.CoreApi;
using uhx.sys.seri.builder.Extract;

@:nullSafety(Strict) class DerivedCoreProperties extends Ucd<DerivedData> {

    override private function get_name():String return 'DerivedCoreProperties';

    public function new(res:String, ver:Version) {
        super(res, ver);
    }

    public override function parse():Promise<ResetIterator<DerivedData>> {
        return loadFile()
        .next( c -> {
            (new DerivedIterator( 
                new EReg('\n', 'g').split(c)
                .filter( s -> !s.startsWith('#') && s.trim() != '' )
            ):ResetIterator<DerivedData>);
        } );
    }

    override public function map(iter:ResetIterator<DerivedData>):Array<Context.Field> {
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

@:structInit class DerivedIterator {

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

    public function next():DerivedData {
        index++;
        return DerivedData.fromString(data[index]);
    }

}

abstract DerivedData(EReg) {

    public static final EREG = new EReg("^([A-Z0-9]{4,}(?:\\.\\.)?(?:[A-Z0-9]{4,})?)(?:\\s*);\\s?([a-zA-Z0-9\\_]+)\\s?#\\s?([a-zA-Z\\&]{0,2})\\s*(?:\\[(\\d+)\\])?\\s?([a-zA-Z0-9 \\-\\.<>]+)$", "gm");

    @:from public static inline function fromString(v:String):DerivedData {
        return new DerivedData(EREG, v);
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
        return parts;
    }

    public var property(get, never):String;
    private inline function get_property():String {
        return this.matched(2);
    }

    public var category(get, never):String;
    private inline function get_category():String {
        return this.matched(3);
    }

    public var expectedLength(get, never):Int;
    private inline function get_expectedLength():Int {
        var str = this.matched(4);
        if (str == '') return 0;
        return str.parseInt();
    }

    public var comment(get, never):String;
    private inline function get_comment():String {
        return this.matched(5);
    }

}