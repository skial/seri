package uhx.sys.seri.builder;

import uhx.sys.seri.Range;

using Std;
using StringTools;

@:nullSafety(Strict) @:forward abstract BlockData(Array<String>) from Array<String> to Array<String> {

	public var range(get, never):Range;
	public var block(get, never):String;
	
	public inline function new(v:Array<String>) {
		this = v;
	}
	
	private inline function get_range():Range {
		return this[0] != null
		? this[0].indexOf('..') == -1 
			? new Range( '0x${this[0].trim()}'.parseInt(), '0x${this[0].trim()}'.parseInt() )
			: new Range( '0x${this[0].split("..")[0]}'.parseInt(), '0x${this[0].split("..")[1].trim()}'.parseInt() )
		: new Range(0, 0);
	}
	
	private inline function get_block():String {
		return this[1] != null ? this[1].trim() : '';
	}
	
}