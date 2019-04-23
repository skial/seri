package uhx.sys.seri;

/**
 * ...
 * @author Skial Bainn
 */
@:structInit class Range {

	public static var EMPTY = new Range(0, 0);

	public var min:CodePoint;
	public var max:CodePoint;
	
	public var length(default, null):Int;
	
	public inline function new (min:CodePoint, max:CodePoint) {
		this.min = min;
		this.max = max;
		this.length = (max - min) + 1;
	}
	
	public inline function has(value:Int):Bool {
		return value >= min && value <= max;
	}
	
	public function iterator():Iterator<CodePoint> {
		return new RangeIterator( this );
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