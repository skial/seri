package uhx.sys.seri;

/**
 * ...
 * @author Skial Bainn
 */
@:forward abstract CodePoint(unifill.CodePoint) from unifill.CodePoint to unifill.CodePoint {

	public inline function new(v:unifill.CodePoint) {
		this = v;
	}
	
	@:access( unifill.CodePoint ) @:from public static inline function fromInt(v:Int):CodePoint {
		return new unifill.CodePoint( v );
	}
	
	@:to public inline function toInt():Int {
		return this.toInt();
	}
	
	@:to public inline function toString():String {
		return this.toString();
	}
	
	/**
	 * Manually forward `unifill.CodePoint` operator overloads.
	 * Why is there no obvious builtin way of doing this?
	 */
	@:op(A + B) static function cons(a:CodePoint, b:String):String;
	@:op(A + B) static function snoc(a:String, b:CodePoint):String;
	@:op(A + B) static function addInt(a:CodePoint, b:Int):CodePoint;
	@:op(A - B) static function sub(a:CodePoint, b:CodePoint):Int;
	@:op(A - B) static function subInt(a:CodePoint, b:Int):CodePoint;
	@:op(A == B) static function eq(a:CodePoint, b:CodePoint):Bool;
	@:op(A != B) static function ne(a:CodePoint, b:CodePoint):Bool;
	@:op(A < B) static function lt(a:CodePoint, b:CodePoint):Bool;
	@:op(A <= B) static function lte(a:CodePoint, b:CodePoint):Bool;
	@:op(A > B) static function gt(a:CodePoint, b:CodePoint):Bool;
	@:op(A >= B) static function gte(a:CodePoint, b:CodePoint):Bool;
	
}