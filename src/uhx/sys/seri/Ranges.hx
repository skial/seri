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
		if (values.length == 0) {
			values.push( range );
			return true;

		}

		var index = 0;
		var local:Range;
		var insertIndex = -1;
		var added = false;
		var merge = false;

		while (index < values.length) {
			local = values[index];
			
			if (merge) {
				if (index >= 0 && index + 1 < values.length) {
					var next = values[index + 1];

					if (local.max + 1 == next.min) {
						local.max = next.max;
						values.splice(index + 1, 1);

					}

				}

				if (index >= 1) {
					var previous = values[index - 1];

					if (local.min - 1 == previous.max) {
						previous.max = local.max;
						values.splice(index, 1);

					}

				}

				return true;

			} else {

				if (range.min == local.min - 1) {
					local.min--;
					added = true;
					merge = values.length > 1;
				}

				if (range.max == local.max + 1) {
					local.max++;
					added = true;
					merge = values.length > 1;
				}

				if (local.min > range.max) {
					// `range` needs to be inserted before `local`.
					insertIndex = index;
					break;

				}
				
				if (range.min >= local.min && range.max <= local.max) {
					// `range` exists within an existing `local`.
					merge ? continue : return added;

				}

				if (range.min >= local.min && range.min <= local.max && range.max > local.max) {
					local.max = range.max;
					merge = true;

				} else if (range.min < local.min && range.max >= local.min && range.max <= local.max) {
					local.min = range.min;
					merge = true;

				}

			}

			index++;

		}

		if (insertIndex != -1) {
			values.insert(insertIndex, range);
			return true;

		}

		values.push( range );

		return true;
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
		var u = new Ranges([]);

		for (r in a.values) u.add( r );
		for (r in b.values) u.add( r );

		return u;
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