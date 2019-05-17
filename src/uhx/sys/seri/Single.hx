package uhx.sys.seri;

@:structInit class Single extends Range {

    public static var EMPTY = new Single(0);
    
    public inline function new(codepoint:Int) {
        super(codepoint, codepoint);
    }

}