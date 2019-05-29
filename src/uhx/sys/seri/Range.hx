package uhx.sys.seri;

import unifill.CodePoint;

@:forward @:forwardStatics abstract Range(RangeImpl) from RangeImpl to RangeImpl {

	public static var EMPTY = new Range(0, 0);

	public var length(get, never):Int;
	private inline function get_length() return this.max - this.min;

	public inline function new(min:Int, max:Int) {
		this = new RangeImpl( min, max );
	}

	public inline function has(value:Int):Bool {
		return value >= this.min && value <= this.max;
	}

	public inline function iterator():Iterator<CodePoint> {
		return new RangeIterator( this );
	}

	@:from public static inline function fromInt(v:Int):Range {
		return new RangeImpl( v, v );
	}

	/* Creates a `Range` using the first and last indexes of the array. */
	@:from public static inline function fromArray(v:Array<Int>):Range {
		return new RangeImpl( v[0], v[v.length-1] );
	}
	
}

@:structInit class RangeImpl {

	public var min:Int;
	public var max:Int;
	
	public inline function new (min:Int, max:Int) {
		this.min = min;
		this.max = max;
	}
	
}

@:structInit private class RangeIterator {
	
	public var range:Range;
	public var current:CodePoint;
	
	public inline function new(range:Range) {
		this.range = range;
		this.current = range.min;
	}
	
	public function next():CodePoint {
		return current = current.toInt() + 1;
	}
	
	public function hasNext():Bool {
		return current <= range.max;
	}
	
}