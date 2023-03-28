package uhx.sys.seri;

@:forward enum abstract Version(String) from String to String {
	public var v700 = '7.0.0';
	public var v800 = '8.0.0';
	public var v900 = '9.0.0';
	public var v1000 = '10.0.0';
	public var v1100 = '11.0.0';
	public var v1200 = '12.0.0';
	public var v1210 = '12.1.0';
	public var v1300 = '13.0.0';
	public var v1400 = '14.0.0';
	public var v1500 = '15.0.0';
	public var v1510 = '15.1.0';
	public var current = v1510;
}