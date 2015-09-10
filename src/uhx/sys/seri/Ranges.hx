package uhx.sys.seri;

using Lambda;

/**
 * ...
 * @author Skial Bainn
 */
class Ranges {

	public var ranges:Array<Range>;
	public var min(default, null):CodePoint;
	public var max(default, null):CodePoint;
	public var length(default, null):Int = 0;
	
	public inline function new(ranges:Array<Range>) {
		this.ranges = ranges;
		this.min = ranges[0].min;
		this.max = ranges[ranges.length - 1].max;
		for (range in ranges) length += (range.max - range.min) + 1;
	}
	
	public inline function has(value:Int):Bool {
		return ranges.exists( function(r) return r.has( value ) );
	}
	
	public function iterator():Iterator<CodePoint> {
		return new RangesIterator( this );
	}
	
}

private class RangesIterator {
	
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