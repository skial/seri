package uhx.sys.seri.builder;

using Std;

@:nullSafety(Strict) @:forward abstract UnicodeData(Array<String>) from Array<String> to Array<String> {

	public var codepoint(get, never):CodePoint;
	public var name(get, never):String;
	public var category(get, never):String;
	
	public inline function new(v:Array<String>) {
		this = v;
		if (v.length != 15) {
			#if debug trace( v ); #end
			throw 'Each row of UnicodeData.txt should be 14 columns long, but was ${v.length} separated by a `;`.';
		}
	}
	
	private inline function get_codepoint():CodePoint {
		return this[0] != null 
			? CodePoint.fromInt( '0x${this[0]}'.parseInt() )
			: -1;
	}
	
	private inline function get_name():String {
		return this[1] != null ? this[1] : '';
	}
	
	private inline function get_category():String {
		return this[2] != null ? this[2] : '';
	}
	
}