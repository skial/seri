package uhx.sys.seri;

@:forward enum abstract Version(String) from String to String {
	public var v700 = '7.0.0';
	public var current = v700;
}