# seri

> Haitian Creole for range

Seri provides convinence methods to Unicode data. Get the range of codepoints for a
specific Block, Script or Category. Get an array of available Blocks,
Scripts or Category identifiers.

## Installation

Using [lix-pm](https://github.com/lix-pm/lix.client), just type `lix download`.

## API

### [Seri] API

```Haxe
 class Seri {
	public static function getCategory(category:String):Ranges;
	public static function getScript(script:String):Ranges;
	public static function getBlock(block:String):Range;
}
```

### [Range] API

```Haxe
class Range {
	public var min:CodePoint;
	public var max:CodePoint;
	public var length(default, null):Int;
	
	public inline function new(min:CodePoint, max:CodePoint);	
	public inline function has(value:Int):Bool;
	public function iterator():Iterator<CodePoint>;
}
```

### [Ranges] API

```Haxe
class Ranges {
	public var ranges:Array<Range>;
	public var min(default, null):CodePoint;
	public var max(default, null):CodePoint;
	public var length(default, null):Int;
	
	public inline function new(ranges:Array<Range>);
	public inline function has(value:Int):Bool;
	public function iterator():Iterator<CodePoint>;
}
```

### [CodePoint] API

```Haxe
@:forward abstract CodePoint(unifill.CodePoint) from unifill.CodePoint to unifill.CodePoint {
	public inline function new(v:unifill.CodePoint);
	@:from public static inline function fromInt(v:Int):CodePoint;
	@:to public inline function toInt():Int;
	@:to public inline function toString():String;
}
```
	
[Seri]: https://github.com/skial/seri/blob/master/src/uhx/sys/Seri.hx
[Range]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/Range.hx
[Ranges]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/Ranges.hx
[CodePoint]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/CodePoint.hx