package uhx.sys.seri.builder;

using StringTools;

class DataIterator {

    private var step:Int = 1;
    private var index:Int = 0;
    private var length:Int = 0;
    private var self:Array<String>;

    public function new(parts:Array<String>) {
        length = parts.length;
        self = parts;
    }

    public function reset():Void {
        index = 0;
    }

    public function hasNext():Bool {
        return index < (length -1);
    }

    public function next():UnicodeData {
        var data = new UnicodeData( self[index].split(';') );
        // @see https://unicode.org/reports/tr44/#Code_Point_Ranges
        if (data.name.startsWith('<') && data.name.endsWith('First>')) {
            var _next = new UnicodeData( self[index+1].split(';') );
            data.name = _next.name.substring(1, _next.name.lastIndexOf(', Last>'));
            data.range = new Range(data.range.min, _next.range.min);
            index += step;
        }
        index += step;
        return data;
    }

}