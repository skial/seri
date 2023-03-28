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

## Adding a new or rebuilding a version.

Download the following:

- `Blocks.txt`
- `DerivedCoreProperties.txt`
- `PropList.txt`
- `Scripts.txt` 
- `UnicodeData.txt`

from the Unicode site and save to `res/{version}/` as `txt` or `gzip`s. Unicode version `13.0.0` files can be found at `https://www.unicode.org/Public/13.0.0/ucd/`.

Then run:
- `haxe build.template.hxml -D seri.version={version} -D dryrun`

If that run without errors being thrown, run:
- `haxe build.template.hxml -D seri.version={version} -D save`.

This will save Haxe files into `src/uhx/sys/seri/v{version}`. You need to update `Block.hx`, `Script.hx`, `Category.hx`, `Version.hx` and `Unicode.hx` 
manually to point to the latest release.
	
[Seri]: https://github.com/skial/seri/blob/master/src/uhx/sys/Seri.hx
