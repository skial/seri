package uhx.sys.seri.builder;

@:forward enum abstract Format(String) from String to String {
	public var Json = 'json';
	public var Haxe = 'haxe';
}