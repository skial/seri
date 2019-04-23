package uhx.sys.seri.builder;

typedef Response = {
	var categories:Array<String>;
	var scripts:Array<String>;
	var blocks:Array<String>;
	var codepoints:Points;
}

typedef Points = {
	var blocks:Map<String, Range>;
	var scripts:Map<String, Array<Range>>;
	var categories:Map<String, Array<Range>>;
}