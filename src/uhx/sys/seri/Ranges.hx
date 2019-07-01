package uhx.sys.seri;

import unifill.CodePoint;

using Lambda;

@:structInit class Ranges {

	public static var EMPTY = new Ranges([Range.EMPTY]);

	public var values:Array<Range>;
	public var min(default, null):CodePoint;
	public var max(default, null):CodePoint;
	public var length(get, null):Int;
	
	public inline function new(ranges:Array<Range>) {
		values = ranges;
		if (values.length == 0) values = EMPTY.values;
		min = values[0].min;
		max = values[values.length - 1].max;
	}

	private inline function get_length() return max - min;
	
	public inline function has(value:Int):Bool {
		return values.exists( r -> r.has( value ) );
	}
	
	public inline function iterator():Iterator<CodePoint> {
		return new RangesIterator( this );
	}

	public static function intersection(a:Ranges, b:Ranges):Range {
		var r = new Range(0, 0); // Default is empty/disjoint.
		var c = a.values.concat( b.values );

		switch c.length {
			case 1: return c[0];
			case 2: return Range.intersection(c[0], c[1]);
			case _:
				var len = 0;
				r = c[0];
				while (len < (c.length-1)) {
					r = Range.intersection(r, c[len+1]);
					len++;
				}
		}

		return r;
	}

	// @see https://en.wikipedia.org/wiki/Union_(set_theory)
	public static function union(a:Ranges, b:Ranges):Ranges {
		var c = a.values.concat( b.values );
		var r = [c[0]];
		var idx = 1;
		var len = c.length-1;

		while (idx <= len) {
			var lidx = r.length-1;
			var a = r[lidx];
			var b = c[idx];
			var bmin = b.min - 1;
			var bmax = b.max - 1;

			if (bmin <= a.min && bmax >= a.max) {
				r[lidx] = b;

			} else if (a.min <= bmin && a.max >= bmin && bmax >= a.max) {
				r[lidx].max = b.max;

			} else if (bmin <= a.min && bmax >= a.min && a.max >= bmax) {
				r[lidx].min = b.min;

			} else if (a.min > b.min) {
				r[lidx] = b;
				r.push( a );

			}

			idx++;
		}

		return new Ranges(r);
	}

	// @see https://en.wikipedia.org/wiki/Complement_(set_theory)
	public static function complement(a:Ranges, ?max:Int = 0x10FFFF):Ranges {
		var r = [];
		var idx = 0;

		if (a.min-1 > 0) r.push(new Range(0, a.min-1));

		while (idx <= a.values.length-1) {
			var b = a.values[idx];
			var a = r[r.length-1];

			var bmin = b.min-1;

			if (bmin < a.max) a.max = bmin;

			r.push( new Range(b.max+1, max) );

			idx++;
		}

		return new Ranges(r);
	}
	
}

@:structInit private class RangesIterator {
	
	public var ranges:Ranges;
	public var current:CodePoint;
	public var rangeIndex:Int = 0;
	
	public inline function new(ranges:Ranges) {
		this.ranges = ranges;
		this.current = ranges.values[0].min;
	}
	
	public function next():CodePoint {
		var result = current;
		current = current.toInt() + 1;
		return result;
	}
	
	public function hasNext():Bool {
		if (current <= ranges.values[rangeIndex].max) {
			return true;
			
		} else if (rangeIndex <= ranges.values.length) {
			rangeIndex++;
			if (ranges.values[rangeIndex] != null) {
				current = ranges.values[rangeIndex].min;
				return true;
			}
			
		}
		
		return false;
	}
	
}