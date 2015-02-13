package uhx.sys.seri;

import uhx.sys.seri.Range;

using Std;
using StringTools;

/**
 * ...
 * @author Skial Bainn
 */
@:forward abstract ScriptData(Array<String>) from Array<String> to Array<String> {
	
	public var range(get, never):Range;
	public var script(get, never):String;
	public var category(get, never):String;

	public inline function new(v:Array<String>) {
		this = v;
	}
	
	private inline function get_range():Range {
		return this[0].indexOf('..') == -1 
			? { 
				min: '0x${this[0].trim()}'.parseInt(), 
				max: '0x${this[0].trim()}'.parseInt() 
			} : {
				min: '0x${this[0].split("..")[0]}'.parseInt(),
				max: '0x${this[0].split("..")[1].trim()}'.parseInt()
			}
	}
	
	private inline function get_script():String {
		return this[1].trim();
	}
	
	private inline function get_category():String {
		return this[2].ltrim().substring(0, 2);
	}
	
}