package uhx.sys.seri.builder;

using Std;
using StringTools;

@:nullSafety(Strict) @:forward abstract UnicodeData(Array<String>) from Array<String> to Array<String> {

	//public var codepoint(get, never):Null<Int>;
	public var range(get, set):Range;
	public var name(get, set):String;
	public var category(get, never):String;
	
	public inline function new(v:Array<String>) {
		this = v;
		if (v.length != 15) {
			throw 'Each row of UnicodeData.txt should be 14 columns long, but was ${v.length} separated by a `;`.';
		}
	}
	
	private inline function get_codepoint():Null<Int> {
		return this[0] != null 
			? '0x${this[0]}'.parseInt()
			: null;
	}
	private inline function get_range():Range {
		return this[0] != null
			? this[0].indexOf('..') > -1 
				? this[0].split('..').map( s -> '0x${s}'.parseInt() )
				: '0x${this[0]}'.parseInt()
			: Range.EMPTY;
	}

	private inline function set_range(v:Range):Range {
		this[0] = v.min != v.max
			? '${v.min.hex(4)}..${v.max.hex(4)}'
			: v.min.hex(4);
		return v;
	}
	
	private inline function get_name():String {
		return this[1] != null ? this[1] : '';
	}

	private inline function set_name(v:String):String {
		return this[1] = v;
	}
	
	private inline function get_category():String {
		return this[2] != null ? this[2] : '';
	}
	
}