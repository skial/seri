# seri

> Haitian Creole for range

Seri provides convinence methods to Unicode data. Get codepoints for a
specific Block, Script or Category. Also get an array of available Blocks,
Scripts or Category identifiers.

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

#### `Seri.getCategory(category:String):Array<CodePoint>`

#### `Seri.getScript(script:String):Array<CodePoint>`

#### `Seri.getBlock(block:String):Array<CodePoint>`

## Macros

The static class `uhx.sys.Seri` methods are mainly `macro` methods, that is,
methods that only exist inside the Haxe compiler as its generating your
project.

The reason for this is to build a Unicode class which holds the information you
only need, not the __entire__ Unicode database. If you call `Seri.getCategory('Zs')`
the string map `uhx.sys.seri.v700.Unicode.codePoints` will only contain the following
codepoints.

```Haxe
[32,160,8192,8193,8194,8195,8196,8197,8198,8199,8200,8201,8202,8239,8287,12288,5760]
```