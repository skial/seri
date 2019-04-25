package uhx.sys.seri.builder;

import haxe.io.Bytes;
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
			? new Range( '0x${this[0]}'.parseInt(), '0x${this[0]}'.parseInt() )
			: {
				var parts = this[0].split('..');
				new Range( '0x${parts[0]}'.parseInt(), '0x${parts[1]}'.parseInt() );
			}
		: new Range(-1, -1);
	}
	
	private inline function get_block():String {
		return this[1] != null ? this[1].trim() : '';
	}
	
}