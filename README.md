# seri

> Haitian Creole for range

Seri provides convinence methods to Unicode data. Get codepoints for a
specific Block, Script or Category. Also get an array of available Blocks,
Scripts or Category identifiers.

## Dependencies

To use seri, you will need to install the following libraries.

1. [klas] - `haxelib git klas https://github.com/skial/klas master src`
2. [cmd] - `haxelib git cmd https://github.com/skial/cmd master src`
3. [unifill] - `haxelib install unifill`

## Installation

With haxelib git.
	
```hxml
haxelib git seri https://github.com/skial/seri master src
```

With haxelib local.
	
```hxml
# Download the archive.
https://github.com/skial/seri/archive/master.zip

# Install archive contents.
haxelib local master.zip
```

## Usage

Add seri to your `hxml` file by adding `-lib seri`. Then import seri
by adding `import uhx.sys.Seri;` to your classes.

## API

### [Seri] API

```Haxe
 class Seri {
	public static function getCategory(category:String):Null<Ranges>;
	public static function getScript(script:String):Null<Ranges>;
	public static function getBlock(block:String):Null<Range>;
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
	@:access( unifill.CodePoint ) @:from public static inline function fromInt(v:Int):CodePoint;
	@:to public inline function toInt():Int;
	@:to public inline function toString():String;
}
```

[klas]: https://github.com/skial/klas
[cmd]: https://github.com/skial/cmd
[unifill]: https://github.com/mandel59/unifill
	
[Seri]: https://github.com/skial/seri/blob/master/src/uhx/sys/Seri.hx
[Range]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/Range.hx
[Ranges]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/Ranges.hx
[CodePoint]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/CodePoint.hx