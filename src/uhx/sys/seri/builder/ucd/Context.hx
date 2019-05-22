package uhx.sys.seri.builder.ucd;

typedef Context = {
    fields:Array<Field>,
    pack:String,
    typeName:String,
    rangeType:String,
    version:String,
    template:String,
    output:String,
}

typedef Field = {
    value:String, 
    ident:String, 
    range:String,
}