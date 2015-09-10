package uhx.sys.seri;

/**
 * ...
 * @author Skial Bainn
 */
class Range {
	public var min:CodePoint;
	public var max:CodePoint;
	
	public var length(get, never):Int;
	
	public inline function new (min:CodePoint, max:CodePoint) {
		this.min = min;
		this.max = max;
	}
	
	private function get_length():Int {
		return (max - min) + 1;
	}
	
}