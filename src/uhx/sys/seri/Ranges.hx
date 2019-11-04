package uhx.sys.seri;

import unifill.CodePoint;

using Lambda;

@:structInit class Ranges {

	public static var EMPTY = new Ranges([Range.EMPTY]);

	public var values:Array<Range>;
	public var min(get, null):Int;
	public var max(get, null):Int;
	public var length(get, null):Int;
	
	public inline function new(ranges:Array<Range>) {
		values = ranges;
		//if (values.length == 0) values = EMPTY.values;
	}

	private inline function get_min() return values[0].min | 0;
	private inline function get_max() return values[values.length - 1].max | 0;
	private inline function get_length() return max - min;
	
	public function has(value:Int):Bool {
		for (range in values) if (range.has(value)) return true;
		return false;
	}

	public inline function copy():Ranges {
		return new Ranges([for (r in this.values) r.copy()]);
	}

	/**
		Adds `range` **without** merging overlapping values. Attempts to find
		sorted position before inserting.
	**/
	public function insert(range:Range):Void {
		var idx = values.length-1;

		for (i in 0...values.length) {
			if (range.min >= values[i].min && range.max <= values[i].max) {
				idx = i;
				break;
			} else if (range.min < values[i].min) {
				idx = i;
				break;
			} else if (range.min > values[i].min) {
				idx = i+1;
			}
		}
		
		values.insert(idx < 0 ? 0 : idx, range);
	}

	/**
		Merges `range` with existing `values` if possible.
		Returns false if **_nothing_** was inserted.
	**/
	public function add(range:Range):Bool {
		var idx = values.length;
		var inRange = false;
		for (i in 0...values.length) {
			if (i+1 <= (values.length-1) && range.min-1 == values[i].max && range.max == values[i+1].min-1) {
				var r = new Range(values[i].min, values[i+1].max);
				values[i] = r;
				values.splice(i+1, 1);
				inRange = true;
				break;
			} else if (range.min-1 == values[i].max) {
				var copy = values[i].copy();
				copy.max = range.max;
				values[i] = copy;
				inRange = true;
				break;
			} else if (range.max == values[i].min-1) {
				var copy = values[i].copy();
				copy.min = range.min;
				values[i] = copy;
				inRange = true;
				break;
			} else if (range.min > values[i].min && range.max < values[i].max) {
				idx = i;
				inRange = true;
				break;
			} else if (range.min < values[i].min && range.max < values[i].max) {
				idx = i;
				//range = new Range(range.min, values[i].min -1);
				break;
			} else if (range.min < values[i].max && range.max > values[i].max) {
				idx = i+1;
				//range = new Range(values[i].max + 1, range.max);
				break;
			}
		}

		if (!inRange) {
			values.insert(idx, range);
		}
		return !inRange;
	}

	public function remove(range:Range):Bool {
		if (range.max < min || range.min > max) return false;

		if (range.min <= min && range.max >= max) {
			values.splice(0, values.length);
			return true;

		} else {
			var idx = 0;

			while (idx < values.length) {
				var r = values[idx];

				if (range.min <= r.min && range.max >= r.max) {
					values.splice(idx, 1);
					continue;
				}

				if (range.min >= r.min && range.max <= r.max) {
					var diff = Range.complement(range, r.min, r.max).values;
					values[idx] = diff.shift();
					var _idx = idx+1;
					for (v in diff) {
						values.insert(_idx, v);
						_idx++;
					}
					return true;
				}

				if (range.min >= r.min && range.min <= r.max) {
					r.max = range.min - 1;

				} else if (range.max >= r.min && range.max <= r.max) {
					r.min = range.max + 1;
					return true;

				}

				idx++;
			}

			return idx != 0;
		}

		return false;
	}

	public function clamp(min:Int, max:Int):Ranges {
		if (this.min >= min && this.max <= max) return this;
		var rs = new Ranges([]);

		for (r in values) {
			var _r = r.copy();
			if (r.min < min) _r.min = min;
			if (r.max > max) _r.max = max;
			rs.values.push( _r );
		}

		return rs;
	}
	
	public inline function iterator():Iterator<Int> {
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
				var t = c[0];
				var match = false;
				while (len < (c.length-1)) {
					if ((t.has(c[len+1].min) || t.has(c[len+1].max)) || (c[len+1].has(t.min) || c[len+1].has(t.max))) {
						t.min = t.min > c[len+1].min ? t.min : c[len+1].min;
						t.max = t.max < c[len+1].max ? t.max : c[len+1].max;
						match = true;

					}
					len++;
				}
				if (match) r = t;
		}
		return r;
	}

	// @see https://en.wikipedia.org/wiki/Union_(set_theory)
	public static function union(a:Ranges, b:Ranges):Ranges {
		var c = a.values.concat( b.values.copy() );
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
	public static function complement(a:Ranges, ?min:Int = 0, ?max:Int = 0x10FFFF):Ranges {
		var r = [];
		var idx = 0;

		if (a.min-1 > min) r.push(new Range(min, a.min-1));

		while (idx <= a.values.length-1) {
			var b = a.values[idx];
			var a = r[r.length-1];
			if (a == null) a = new Range(min, min);

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
	public var current:Int;
	public var rangeIndex:Int = 0;
	
	public inline function new(ranges:Ranges) {
		this.ranges = ranges;
		this.current = ranges.values[0].min;
	}
	
	public function next():Int {
		var result = current;
		current = current + 1;
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