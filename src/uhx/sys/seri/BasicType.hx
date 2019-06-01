package uhx.sys.seri;

import uhx.sys.seri.Category;

// @:see https://www.unicode.org/versions/Unicode12.0.0/ch02.pdf#G286941
enum abstract BasicType(Int) {

    public var Graphic = 0;
    public var Format;
    public var Control;
    public var PrivateUse;
    public var Surrogate;
    public var Noncharacter;
    //public var Reserved;  // `Cn` falls into both Noncharacter and Reserved.

    @:from static inline function fromCategory(c:Category):BasicType {
        return switch c {
            case L, Ll, Lm, Lo, Lt, Lu, 
                 M, Mc, Me, Mn,
                 N, Nd, Nl, No,
                 P, Pc, Pd, Pe, Pf, Pi, Po, Ps,
                 S, Sc, Sk, Sm, So,
                 Zs:
                Graphic;
            
            case Cf, Zl, Zp:
                Format;

            case Cc:
                Control;

            case Co:
                PrivateUse;
            
            case Cs:
                Surrogate;

            case Cn:
                Noncharacter;
            
            case _:
                Noncharacter;
        }
    }

}