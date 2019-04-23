package uhx.sys.seri.builder;

class DataIterator {

    private var step:Int = 1;
    private var index:Int = 0;
    private var length:Int = 0;
    private var self:Array<String>;

    public function new(parts:Array<String>) {
        length = parts.length;
        self = parts;
    }

    public function hasNext():Bool {
        return index < (length -1);
    }

    public function next():UnicodeData {
        var data = new UnicodeData( self[index].split(';') );
        index += step;
        return data;
    }

}