package uhx.sys.seri;

import uhx.sys.seri.v1510.Category as GC;

// @see https://www.unicode.org/versions/Unicode12.0.0/ch04.pdf#G134153
@:notNull 
@:forward 
@:forwardStatics 
enum abstract Category(GC) from GC to String {
    public var Cc = GC.Cc;
    public var Cf = GC.Cf;
    public var Co = GC.Co;
    public var Cs = GC.Cs;
    public var C = GC.C;
    public var Ll = GC.Ll;
    public var Lm = GC.Lm;
    public var Lo = GC.Lo;
    public var Lt = GC.Lt;
    public var Lu = GC.Lu;
    public var L = GC.L;
    public var Mc = GC.Mc;
    public var Me = GC.Me;
    public var Mn = GC.Mn;
    public var M = GC.M;
    public var Nd = GC.Nd;
    public var Nl = GC.Nl;
    public var No = GC.No;
    public var N = GC.N;
    public var Pc = GC.Pc;
    public var Pd = GC.Pd;
    public var Pe = GC.Pe;
    public var Pf = GC.Pf;
    public var Pi = GC.Pi;
    public var Po = GC.Po;
    public var Ps = GC.Ps;
    public var P = GC.P;
    public var Sc = GC.Sc;
    public var Sk = GC.Sk;
    public var Sm = GC.Sm;
    public var So = GC.So;
    public var S = GC.S;
    public var Zl = GC.Zl;
    public var Zp = GC.Zp;
    public var Zs = GC.Zs;
    public var Z = GC.Z;
    
    public var Letter_UpperCase = GC.Lu;
    public var Letter_LowerCase = GC.Ll;
    public var Letter_TitleCase = GC.Lt;
    public var Letter_Modifier = GC.Lm;
    public var Mark_NonSpacing = GC.Mn;
    public var Mark_SpacingCombining = GC.Mc;
    public var Mark_Enclosing = GC.Me;
    public var Number_DecimalDigit = GC.Nd;
    public var Number_Letter = GC.Nl;
    public var Number_Other = GC.No;
    public var Punctuation_Connector = GC.Pc;
    public var Punctuation_Dash = GC.Pd;
    public var Punctuation_Open = GC.Ps;
    public var Punctuation_Close = GC.Pe;
    public var Punctuation_InitialQuote = GC.Pi;
    public var Punctuation_FinalQuote = GC.Pf;
    public var Punctuation_Other = GC.Po;
    public var Symbol_Math = GC.Sm;
    public var Symbol_Currency = GC.Sc;
    public var Symbol_Modifier = GC.Sk;
    public var Symbol_Other = GC.So;
    public var Separator_Space = GC.Zs;
    public var Separator_Line = GC.Zl;
    public var Separator_Paragraph = GC.Zp;
    public var Other_Control = GC.Cc;
    public var Other_Format = GC.Cf;
    public var Other_Surrogate = GC.Cs;
    public var Other_PrivateUse = GC.Co;
    //public var Other_NotAssigned = Cn;

    @:to public inline function asRange() return this.asRange();
}