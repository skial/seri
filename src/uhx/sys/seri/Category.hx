package uhx.sys.seri;

import uhx.sys.seri.v1200.Category as GC;

// @see https://www.unicode.org/versions/Unicode12.0.0/ch04.pdf#G134153
@:notNull @:forward @:forwardStatics enum abstract Category(GC) from GC {
    public var Letter_UpperCase = Lu;
    public var Letter_LowerCase = Ll;
    public var Letter_TitleCase = Lt;
    public var Letter_Modifier = Lm;
    public var Mark_NoneSpacing = Mn;
    public var Mark_SpacingCombing = Mc;
    public var Mark_enclosing = Me;
    public var Punctuation_Connector = Pc;
    public var Punctuation_Dash = Pd;
    public var Punctuation_Open = Ps;
    public var Punctuation_Close = Pe;
    public var Punctuation_InitialQuote = Pi;
    public var Punctuation_FinalQuote = Pf;
    public var Punctuation_Other = Po;
    public var Symbol_Math = Sm;
    public var Symbol_Currency = Sc;
    public var Symbol_Modifier = Sk;
    public var Symbol_Other = So;
    public var Separator_Space = Zs;
    public var Separator_Line = Zl;
    public var Separator_Paragraph = Zp;
    public var Other_Control = Cc;
    public var Other_Format = Cf;
    public var Other_Surrogate = Cs;
    public var Other_PrivateUse = Co;
    //public var Other_NotAssigned = Cn;

    @:to public inline function asRange() return this.asRange();
}