package uhx.sys.seri;

import unifill.CodePoint;

using Lambda;

@:structInit class Ranges {

	public static var EMPTY = new Ranges([Range.EMPTY]);

	public var ranges:Array<Range>;
	public var min(default, null):CodePoint;
	public var max(default, null):CodePoint;
	public var length(default, null):Int = 0;
	
	public inline function new(ranges:Array<Range>) {
		this.ranges = ranges;
		min = ranges[0].min;
		max = ranges[ranges.length - 1].max;
		length = max - min;
	}
	
	public inline function has(value:Int):Bool {
		return ranges.exists( r -> r.has( value ) );
	}
	
	public inline function iterator():Iterator<CodePoint> {
		return new RangesIterator( this );
	}
	
}

@:structInit private class RangesIterator {
	
	public var ranges:Ranges;
	public var current:CodePoint;
	public var rangeIndex:Int = 0;
	
	public inline function new(ranges:Ranges) {
		this.ranges = ranges;
		this.current = ranges.ranges[0].min;
	}
	
	public function next():CodePoint {
		var result = current;
		current = current.toInt() + 1;
		return result;
	}
	
	public function hasNext():Bool {
		if (current <= ranges.ranges[rangeIndex].max) {
			return true;
			
		} else if (rangeIndex <= ranges.ranges.length) {
			rangeIndex++;
			if (ranges.ranges[rangeIndex] != null) {
				current = ranges.ranges[rangeIndex].min;
				return true;
			}
			
		}
		
		return false;
	}
	
}