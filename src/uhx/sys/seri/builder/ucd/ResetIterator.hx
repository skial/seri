package uhx.sys.seri.builder.ucd;

@:forward @:forwardStatics @:notNull 
abstract ResetIterator<T>(TResetIterator<T>) from TResetIterator<T> to Iterator<T> {
    

}

typedef TResetIterator<T> = Iterator<T> & {
    public function reset():Void;
}