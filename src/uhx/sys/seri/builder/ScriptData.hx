package uhx.sys.seri.builder;

import uhx.sys.seri.Range;

using Std;
using StringTools;

/**
 * ...
 * @author Skial Bainn
 */
@:nullSafety(Strict) @:forward abstract ScriptData(Array<String>) from Array<String> to Array<String> {
	
	public var range(get, never):Range;
	public var script(get, never):String;
	public var category(get, never):String;

	public inline function new(v:Array<String>) {
		this = v;
	}
	
	private inline function get_range():Range {
		return this[0] != null ? 
		this[0].indexOf('..') == -1 
			? new Range( '0x${this[0]}'.parseInt(), '0x${this[0]}'.parseInt() )
			: {
				var parts = this[0].split('..');
				new Range( '0x${parts[0]}'.parseInt(), '0x${parts[1]}'.parseInt() );
			}
		: new Range(-1, -1);
	}
	
	private inline function get_script():String {
		return this[1] != null ? this[1].trim() : '';
	}
	
	private inline function get_category():String {
		return this[2] != null ? this[2].ltrim().substring(0, 2) : '';
	}
	
}