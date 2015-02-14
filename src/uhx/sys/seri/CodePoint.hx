package uhx.sys.seri;

/**
 * ...
 * @author Skial Bainn
 */
@forward abstract CodePoint(unifill.CodePoint) from unifill.CodePoint to unifill.CodePoint {

	public inline function new(v:unifill.CodePoint) {
		this = v;
	}
	
	@:noCompletion @:from public static inline function fromInt(v:Int):CodePoint {
		return new unifill.CodePoint( v );
	}
	
	@:noCompletion @:to public inline function toInt():Int {
		return this.toInt();
	}
	
}