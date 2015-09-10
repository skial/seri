# seri

> Haitian Creole for range

Seri provides convinence methods to Unicode data. Get codepoints for a
specific Block, Script or Category. Also get an array of available Blocks,
Scripts or Category identifiers.

## Dependencies

To use seri, you will need to install the following libraries.

1. [klas] - `haxelib git klas https://github.com/skial/klas master src`
2. [cmd] - `haxelib git cmd https://github.com/skial/cmd master src`
3. unifill - `haxelib install unifill`

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

### Seri API

#### `Seri.getCategory(category:String):Array<Range>`

#### `Seri.getScript(script:String):Null<Range>`

#### `Seri.getBlock(block:String):Null<Range>`

### Range API

#### `Range::min:CodePoint`

#### `Range::max:CodePoint`

#### `Range::length:Int`

[klas]: https://github.com/skial/klas
[cmd]: https://github.com/skial/cmd