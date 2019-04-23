package uhx.sys.seri.builder;

using StringTools;

class ScriptIterator {

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

    public function next():ScriptData {
        var value = self[index];
        if (value.startsWith('#') || value.trim() == '') value = '';
        var data = new ScriptData( value.split(';') );
        index += step;
        return data;
    }

}