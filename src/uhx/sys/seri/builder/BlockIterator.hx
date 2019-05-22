package uhx.sys.seri.builder;

class BlockIterator {

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

    public function next():BlockData {
        var data = new BlockData( self[index].split(';') );
        index += step;
        return data;
    }

}