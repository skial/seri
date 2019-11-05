# seri

> Haitian Creole for range

Seri provides convinence methods to Unicode data. Get the range of codepoints for a
specific Block, Script or Category. Get an array of available Blocks,
Scripts or Category identifiers.

| Php | Python | Java | C# | Js/Node | Interp | Neko | HashLink | Lua | CPP |
| - | -| - | - | - | -| - | - | - | - |
| ✅ | ✅     | ✅  | ✅ | ✅     | ✅ | ✅  | ✅       | ➖ | ➖ |

## Installation

`lix install gh:skial/seri`

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
	public var min:Int;
	public var max:Int;
	public var length(default, null):Int;
	
	public inline function new(min:Int, max:Int);	
	public inline function has(value:Int):Bool;
	public inline function copy():Range;
	public function iterator():Iterator<CodePoint>;

	public static function intersection(a:Range, b:Range):Range;
	public static function union(a:Range, b:Range):Ranges;
	public static function complement(a:Range, ?min:Int, ?max:Int):Ranges;
}
```

### [Ranges] API

```Haxe
class Ranges {
	public var values:Array<Range>;
	public var min(default, null):Int;
	public var max(default, null):Int;
	public var length(default, null):Int;
	
	public inline function new(ranges:Array<Range>);
	public function has(value:Int):Bool;
	public inline function copy():Ranges;
	public function insert(range:Range):Void;
	public function add(range:Range):Bool;
	public function remove(range:Range):Bool;
	public function clamp(min:Int, max:Int):Ranges;
	public function iterator():Iterator<CodePoint>;

	public static function intersection(a:Ranges, b:Ranges):Ranges;
	public static function union(a:Ranges, b:Ranges):Ranges;
	public static function complement(a:Ranges, ?min:Int, ?max:Int):Ranges;
}
```

## Adding a new or rebuilding a version.

Download `UnicodeData.txt`, `Blocks.txt` and `Scripts.txt` from the Unicode site and save to `res/{version}/` as gzips. Unicode version `12.0.0` files can be found at `https://www.unicode.org/Public/12.0.0/ucd/`.

Then run:
- `haxe build.template.hxml -D seri.version={version} -D dryrun`

If that run without errors being thrown, run:
- `haxe build.template.hxml -D seri.version={version} -D save`.

This will save Haxe files into `src/uhx/sys/seri/v{version}`. You need to update `Block.hx`, `Script.hx`, `Category.hx`, `Version.hx` and `Unicode.hx` 
manually to point to the latest release.
	
[Seri]: https://github.com/skial/seri/blob/master/src/uhx/sys/Seri.hx
[Range]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/Range.hx
[Ranges]: https://github.com/skial/seri/blob/master/src/uhx/sys/seri/Ranges.hx
