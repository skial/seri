package uhx.sys.seri;

using Std;
using StringTools;

/**
 * ...
 * @author Skial Bainn
 */
@:forward abstract UnicodeData(Array<String>) from Array<String> to Array<String> {

	public var codepoint(get, never):CodePoint;
	public var name(get, never):String;
	public var category(get, never):String;
	
	public inline function new(v:Array<String>) {
		this = v;
		if (v.length != 15) throw 'Each row of UnicodeData.txt should be 14 columns long, but was ${v.length} separated by a `;`.';
	}
	
	private inline function get_codepoint():CodePoint {
		return CodePoint.fromInt( '0x${this[0]}'.parseInt() );
	}
	
	private inline function get_name():String {
		return this[1];
	}
	
	private inline function get_category():String {
		return this[2];
	}
	
}