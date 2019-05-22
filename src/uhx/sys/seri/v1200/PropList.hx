package uhx.sys.seri.v1200;

/**
    This file has be auto-generated. Do NOT edit.
**/

import uhx.sys.seri.*;

@:unicode("12.0.0")
enum abstract PropList(String) {
    
    public var AsciiHexDigit = "ASCII_Hex_Digit";
    public var BidiControl = "Bidi_Control";
    public var Dash = "Dash";
    public var Deprecated = "Deprecated";
    public var Diacritic = "Diacritic";
    public var Extender = "Extender";
    public var HexDigit = "Hex_Digit";
    public var Hyphen = "Hyphen";
    public var IDSBinaryOperator = "IDS_Binary_Operator";
    public var IDSTrinaryOperator = "IDS_Trinary_Operator";
    public var Ideographic = "Ideographic";
    public var JoinControl = "Join_Control";
    public var LogicalOrderException = "Logical_Order_Exception";
    public var NoncharacterCodePoint = "Noncharacter_Code_Point";
    public var OtherAlphabetic = "Other_Alphabetic";
    public var OtherDefaultIgnorableCodePoint = "Other_Default_Ignorable_Code_Point";
    public var OtherGraphemeExtend = "Other_Grapheme_Extend";
    public var OtherIDContinue = "Other_ID_Continue";
    public var OtherIDStart = "Other_ID_Start";
    public var OtherLowercase = "Other_Lowercase";
    public var OtherMath = "Other_Math";
    public var OtherUppercase = "Other_Uppercase";
    public var PatternSyntax = "Pattern_Syntax";
    public var PatternWhiteSpace = "Pattern_White_Space";
    public var PrependedConcatenationMark = "Prepended_Concatenation_Mark";
    public var QuotationMark = "Quotation_Mark";
    public var Radical = "Radical";
    public var RegionalIndicator = "Regional_Indicator";
    public var SentenceTerminal = "Sentence_Terminal";
    public var SoftDotted = "Soft_Dotted";
    public var TerminalPunctuation = "Terminal_Punctuation";
    public var UnifiedIdeograph = "Unified_Ideograph";
    public var VariationSelector = "Variation_Selector";
    public var WhiteSpace = "White_Space";

    public static inline function all():Array<PropList> return [
        AsciiHexDigit, 
        BidiControl, 
        Dash, 
        Deprecated, 
        Diacritic, 
        Extender, 
        HexDigit, 
        Hyphen, 
        IDSBinaryOperator, 
        IDSTrinaryOperator, 
        Ideographic, 
        JoinControl, 
        LogicalOrderException, 
        NoncharacterCodePoint, 
        OtherAlphabetic, 
        OtherDefaultIgnorableCodePoint, 
        OtherGraphemeExtend, 
        OtherIDContinue, 
        OtherIDStart, 
        OtherLowercase, 
        OtherMath, 
        OtherUppercase, 
        PatternSyntax, 
        PatternWhiteSpace, 
        PrependedConcatenationMark, 
        QuotationMark, 
        Radical, 
        RegionalIndicator, 
        SentenceTerminal, 
        SoftDotted, 
        TerminalPunctuation, 
        UnifiedIdeograph, 
        VariationSelector, 
        WhiteSpace, 
    ];

    @:to public inline function asRange():uhx.sys.seri.Ranges {
        return switch this {
            #if !display
            
            case AsciiHexDigit:
                new Ranges([new Range(48, 57), new Range(65, 70), new Range(97, 102)]);
            
            case BidiControl:
                new Ranges([new Single(1564), new Range(8206, 8207), new Range(8234, 8238), new Range(8294, 8297)]);
            
            case Dash:
                new Ranges([new Single(45), new Single(1418), new Single(1470), new Single(5120), new Single(6150), new Range(8208, 8213), new Single(8275), new Single(8315), new Single(8331), new Single(8722), new Single(11799), new Single(11802), new Range(11834, 11835), new Single(11840), new Single(12316), new Single(12336), new Single(12448), new Range(65073, 65074), new Single(65112), new Single(65123), new Single(65293)]);
            
            case Deprecated:
                new Ranges([new Single(329), new Single(1651), new Single(3959), new Single(3961), new Range(6051, 6052), new Range(8298, 8303), new Single(9001), new Single(9002), new Single(917505)]);
            
            case Diacritic:
                new Ranges([new Single(94), new Single(96), new Single(168), new Single(175), new Single(180), new Single(183), new Single(184), new Range(688, 705), new Range(706, 709), new Range(710, 721), new Range(722, 735), new Range(736, 740), new Range(741, 747), new Single(748), new Single(749), new Single(750), new Range(751, 767), new Range(768, 846), new Range(848, 855), new Range(861, 866), new Single(884), new Single(885), new Single(890), new Range(900, 901), new Range(1155, 1159), new Single(1369), new Range(1425, 1441), new Range(1443, 1469), new Single(1471), new Range(1473, 1474), new Single(1476), new Range(1611, 1618), new Range(1623, 1624), new Range(1759, 1760), new Range(1765, 1766), new Range(1770, 1772), new Range(1840, 1866), new Range(1958, 1968), new Range(2027, 2035), new Range(2036, 2037), new Range(2072, 2073), new Range(2275, 2302), new Single(2364), new Single(2381), new Range(2385, 2388), new Single(2417), new Single(2492), new Single(2509), new Single(2620), new Single(2637), new Single(2748), new Single(2765), new Range(2813, 2815), new Single(2876), new Single(2893), new Single(3021), new Single(3149), new Single(3260), new Single(3277), new Range(3387, 3388), new Single(3405), new Single(3530), new Range(3655, 3660), new Single(3662), new Single(3770), new Range(3784, 3788), new Range(3864, 3865), new Single(3893), new Single(3895), new Single(3897), new Range(3902, 3903), new Range(3970, 3972), new Range(3974, 3975), new Single(4038), new Single(4151), new Range(4153, 4154), new Range(4195, 4196), new Range(4201, 4205), new Range(4231, 4236), new Single(4237), new Single(4239), new Range(4250, 4251), new Range(4957, 4959), new Range(6089, 6099), new Single(6109), new Range(6457, 6459), new Range(6773, 6780), new Single(6783), new Range(6832, 6845), new Single(6964), new Single(6980), new Range(7019, 7027), new Single(7082), new Single(7083), new Range(7222, 7223), new Range(7288, 7293), new Range(7376, 7378), new Single(7379), new Range(7380, 7392), new Single(7393), new Range(7394, 7400), new Single(7405), new Single(7412), new Single(7415), new Range(7416, 7417), new Range(7468, 7530), new Range(7620, 7631), new Range(7669, 7673), new Range(7677, 7679), new Single(8125), new Range(8127, 8129), new Range(8141, 8143), new Range(8157, 8159), new Range(8173, 8175), new Range(8189, 8190), new Range(11503, 11505), new Single(11823), new Range(12330, 12333), new Range(12334, 12335), new Range(12441, 12442), new Range(12443, 12444), new Single(12540), new Single(42607), new Range(42620, 42621), new Single(42623), new Range(42652, 42653), new Range(42736, 42737), new Range(42752, 42774), new Range(42775, 42783), new Range(42784, 42785), new Single(42888), new Range(42889, 42890), new Range(43000, 43001), new Single(43204), new Range(43232, 43249), new Range(43307, 43309), new Single(43310), new Single(43347), new Single(43443), new Single(43456), new Single(43493), new Single(43643), new Single(43644), new Single(43645), new Single(43711), new Single(43712), new Single(43713), new Single(43714), new Single(43766), new Single(43867), new Range(43868, 43871), new Single(44012), new Single(44013), new Single(64286), new Range(65056, 65071), new Single(65342), new Single(65344), new Single(65392), new Range(65438, 65439), new Single(65507), new Single(66272), new Range(68325, 68326), new Range(68898, 68899), new Range(68900, 68903), new Range(69446, 69456), new Range(69817, 69818), new Range(69939, 69940), new Single(70003), new Single(70080), new Range(70090, 70092), new Single(70197), new Single(70198), new Range(70377, 70378), new Single(70460), new Single(70477), new Range(70502, 70508), new Range(70512, 70516), new Single(70722), new Single(70726), new Range(70850, 70851), new Range(71103, 71104), new Single(71231), new Single(71350), new Single(71351), new Single(71467), new Range(71737, 71738), new Single(72160), new Single(72244), new Single(72263), new Single(72345), new Single(72767), new Single(73026), new Range(73028, 73029), new Single(73111), new Range(92912, 92916), new Range(92976, 92982), new Range(94095, 94098), new Range(94099, 94111), new Range(119143, 119145), new Range(119149, 119154), new Range(119163, 119170), new Range(119173, 119179), new Range(119210, 119213), new Range(123184, 123190), new Range(123628, 123631), new Range(125136, 125142), new Range(125252, 125254), new Range(125256, 125258)]);
            
            case Extender:
                new Ranges([new Single(183), new Range(720, 721), new Single(1600), new Single(2042), new Single(3654), new Single(3782), new Single(6154), new Single(6211), new Single(6823), new Single(7222), new Single(7291), new Single(12293), new Range(12337, 12341), new Range(12445, 12446), new Range(12540, 12542), new Single(40981), new Single(42508), new Single(43471), new Single(43494), new Single(43632), new Single(43741), new Range(43763, 43764), new Single(65392), new Single(70493), new Range(71110, 71112), new Single(72344), new Range(92994, 92995), new Range(94176, 94177), new Single(94179), new Range(123196, 123197), new Range(125252, 125254)]);
            
            case HexDigit:
                new Ranges([new Range(48, 57), new Range(65, 70), new Range(97, 102), new Range(65296, 65305), new Range(65313, 65318), new Range(65345, 65350)]);
            
            case Hyphen:
                new Ranges([new Single(45), new Single(173), new Single(1418), new Single(6150), new Range(8208, 8209), new Single(11799), new Single(12539), new Single(65123), new Single(65293), new Single(65381)]);
            
            case IDSBinaryOperator:
                new Ranges([new Range(12272, 12273), new Range(12276, 12283)]);
            
            case IDSTrinaryOperator:
                new Ranges([new Range(12274, 12275)]);
            
            case Ideographic:
                new Ranges([new Single(12294), new Single(12295), new Range(12321, 12329), new Range(12344, 12346), new Range(13312, 19893), new Range(19968, 40943), new Range(63744, 64109), new Range(64112, 64217), new Range(94208, 100343), new Range(100352, 101106), new Range(110960, 111355), new Range(131072, 173782), new Range(173824, 177972), new Range(177984, 178205), new Range(178208, 183969), new Range(183984, 191456), new Range(194560, 195101)]);
            
            case JoinControl:
                new Ranges([new Range(8204, 8205)]);
            
            case LogicalOrderException:
                new Ranges([new Range(3648, 3652), new Range(3776, 3780), new Range(6581, 6583), new Single(6586), new Range(43701, 43702), new Single(43705), new Range(43707, 43708)]);
            
            case NoncharacterCodePoint:
                new Ranges([new Range(64976, 65007), new Range(65534, 65535), new Range(131070, 131071), new Range(196606, 196607), new Range(262142, 262143), new Range(327678, 327679), new Range(393214, 393215), new Range(458750, 458751), new Range(524286, 524287), new Range(589822, 589823), new Range(655358, 655359), new Range(720894, 720895), new Range(786430, 786431), new Range(851966, 851967), new Range(917502, 917503), new Range(983038, 983039), new Range(1048574, 1048575), new Range(1114110, 1114111)]);
            
            case OtherAlphabetic:
                new Ranges([new Single(837), new Range(1456, 1469), new Single(1471), new Range(1473, 1474), new Range(1476, 1477), new Single(1479), new Range(1552, 1562), new Range(1611, 1623), new Range(1625, 1631), new Single(1648), new Range(1750, 1756), new Range(1761, 1764), new Range(1767, 1768), new Single(1773), new Single(1809), new Range(1840, 1855), new Range(1958, 1968), new Range(2070, 2071), new Range(2075, 2083), new Range(2085, 2087), new Range(2089, 2092), new Range(2260, 2271), new Range(2275, 2281), new Range(2288, 2306), new Single(2307), new Single(2362), new Single(2363), new Range(2366, 2368), new Range(2369, 2376), new Range(2377, 2380), new Range(2382, 2383), new Range(2389, 2391), new Range(2402, 2403), new Single(2433), new Range(2434, 2435), new Range(2494, 2496), new Range(2497, 2500), new Range(2503, 2504), new Range(2507, 2508), new Single(2519), new Range(2530, 2531), new Range(2561, 2562), new Single(2563), new Range(2622, 2624), new Range(2625, 2626), new Range(2631, 2632), new Range(2635, 2636), new Single(2641), new Range(2672, 2673), new Single(2677), new Range(2689, 2690), new Single(2691), new Range(2750, 2752), new Range(2753, 2757), new Range(2759, 2760), new Single(2761), new Range(2763, 2764), new Range(2786, 2787), new Range(2810, 2812), new Single(2817), new Range(2818, 2819), new Single(2878), new Single(2879), new Single(2880), new Range(2881, 2884), new Range(2887, 2888), new Range(2891, 2892), new Single(2902), new Single(2903), new Range(2914, 2915), new Single(2946), new Range(3006, 3007), new Single(3008), new Range(3009, 3010), new Range(3014, 3016), new Range(3018, 3020), new Single(3031), new Single(3072), new Range(3073, 3075), new Range(3134, 3136), new Range(3137, 3140), new Range(3142, 3144), new Range(3146, 3148), new Range(3157, 3158), new Range(3170, 3171), new Single(3201), new Range(3202, 3203), new Single(3262), new Single(3263), new Range(3264, 3268), new Single(3270), new Range(3271, 3272), new Range(3274, 3275), new Single(3276), new Range(3285, 3286), new Range(3298, 3299), new Range(3328, 3329), new Range(3330, 3331), new Range(3390, 3392), new Range(3393, 3396), new Range(3398, 3400), new Range(3402, 3404), new Single(3415), new Range(3426, 3427), new Range(3458, 3459), new Range(3535, 3537), new Range(3538, 3540), new Single(3542), new Range(3544, 3551), new Range(3570, 3571), new Single(3633), new Range(3636, 3642), new Single(3661), new Single(3761), new Range(3764, 3769), new Range(3771, 3772), new Single(3789), new Range(3953, 3966), new Single(3967), new Range(3968, 3969), new Range(3981, 3991), new Range(3993, 4028), new Range(4139, 4140), new Range(4141, 4144), new Single(4145), new Range(4146, 4150), new Single(4152), new Range(4155, 4156), new Range(4157, 4158), new Range(4182, 4183), new Range(4184, 4185), new Range(4190, 4192), new Range(4194, 4196), new Range(4199, 4205), new Range(4209, 4212), new Single(4226), new Range(4227, 4228), new Range(4229, 4230), new Range(4231, 4236), new Single(4237), new Single(4239), new Range(4250, 4252), new Single(4253), new Range(5906, 5907), new Range(5938, 5939), new Range(5970, 5971), new Range(6002, 6003), new Single(6070), new Range(6071, 6077), new Range(6078, 6085), new Single(6086), new Range(6087, 6088), new Range(6277, 6278), new Single(6313), new Range(6432, 6434), new Range(6435, 6438), new Range(6439, 6440), new Range(6441, 6443), new Range(6448, 6449), new Single(6450), new Range(6451, 6456), new Range(6679, 6680), new Range(6681, 6682), new Single(6683), new Single(6741), new Single(6742), new Single(6743), new Range(6744, 6750), new Single(6753), new Single(6754), new Range(6755, 6756), new Range(6757, 6764), new Range(6765, 6770), new Range(6771, 6772), new Range(6912, 6915), new Single(6916), new Single(6965), new Range(6966, 6970), new Single(6971), new Single(6972), new Range(6973, 6977), new Single(6978), new Single(6979), new Range(7040, 7041), new Single(7042), new Single(7073), new Range(7074, 7077), new Range(7078, 7079), new Range(7080, 7081), new Range(7084, 7085), new Single(7143), new Range(7144, 7145), new Range(7146, 7148), new Single(7149), new Single(7150), new Range(7151, 7153), new Range(7204, 7211), new Range(7212, 7219), new Range(7220, 7221), new Single(7222), new Range(7655, 7668), new Range(9398, 9449), new Range(11744, 11775), new Range(42612, 42619), new Range(42654, 42655), new Single(43010), new Single(43019), new Range(43043, 43044), new Range(43045, 43046), new Single(43047), new Range(43136, 43137), new Range(43188, 43203), new Single(43205), new Single(43263), new Range(43302, 43306), new Range(43335, 43345), new Single(43346), new Range(43392, 43394), new Single(43395), new Range(43444, 43445), new Range(43446, 43449), new Range(43450, 43451), new Range(43452, 43453), new Range(43454, 43455), new Single(43493), new Range(43561, 43566), new Range(43567, 43568), new Range(43569, 43570), new Range(43571, 43572), new Range(43573, 43574), new Single(43587), new Single(43596), new Single(43597), new Single(43643), new Single(43644), new Single(43645), new Single(43696), new Range(43698, 43700), new Range(43703, 43704), new Single(43710), new Single(43755), new Range(43756, 43757), new Range(43758, 43759), new Single(43765), new Range(44003, 44004), new Single(44005), new Range(44006, 44007), new Single(44008), new Range(44009, 44010), new Single(64286), new Range(66422, 66426), new Range(68097, 68099), new Range(68101, 68102), new Range(68108, 68111), new Range(68900, 68903), new Single(69632), new Single(69633), new Single(69634), new Range(69688, 69701), new Single(69762), new Range(69808, 69810), new Range(69811, 69814), new Range(69815, 69816), new Range(69888, 69890), new Range(69927, 69931), new Single(69932), new Range(69933, 69938), new Range(69957, 69958), new Range(70016, 70017), new Single(70018), new Range(70067, 70069), new Range(70070, 70078), new Single(70079), new Range(70188, 70190), new Range(70191, 70193), new Range(70194, 70195), new Single(70196), new Single(70199), new Single(70206), new Single(70367), new Range(70368, 70370), new Range(70371, 70376), new Range(70400, 70401), new Range(70402, 70403), new Range(70462, 70463), new Single(70464), new Range(70465, 70468), new Range(70471, 70472), new Range(70475, 70476), new Single(70487), new Range(70498, 70499), new Range(70709, 70711), new Range(70712, 70719), new Range(70720, 70721), new Range(70723, 70724), new Single(70725), new Range(70832, 70834), new Range(70835, 70840), new Single(70841), new Single(70842), new Range(70843, 70846), new Range(70847, 70848), new Single(70849), new Range(71087, 71089), new Range(71090, 71093), new Range(71096, 71099), new Range(71100, 71101), new Single(71102), new Range(71132, 71133), new Range(71216, 71218), new Range(71219, 71226), new Range(71227, 71228), new Single(71229), new Single(71230), new Single(71232), new Single(71339), new Single(71340), new Single(71341), new Range(71342, 71343), new Range(71344, 71349), new Range(71453, 71455), new Range(71456, 71457), new Range(71458, 71461), new Single(71462), new Range(71463, 71466), new Range(71724, 71726), new Range(71727, 71735), new Single(71736), new Range(72145, 72147), new Range(72148, 72151), new Range(72154, 72155), new Range(72156, 72159), new Single(72164), new Range(72193, 72202), new Range(72245, 72248), new Single(72249), new Range(72251, 72254), new Range(72273, 72278), new Range(72279, 72280), new Range(72281, 72283), new Range(72330, 72342), new Single(72343), new Single(72751), new Range(72752, 72758), new Range(72760, 72765), new Single(72766), new Range(72850, 72871), new Single(72873), new Range(72874, 72880), new Single(72881), new Range(72882, 72883), new Single(72884), new Range(72885, 72886), new Range(73009, 73014), new Single(73018), new Range(73020, 73021), new Range(73023, 73025), new Single(73027), new Single(73031), new Range(73098, 73102), new Range(73104, 73105), new Range(73107, 73108), new Single(73109), new Single(73110), new Range(73459, 73460), new Range(73461, 73462), new Single(94031), new Range(94033, 94087), new Range(94095, 94098), new Single(113822), new Range(122880, 122886), new Range(122888, 122904), new Range(122907, 122913), new Range(122915, 122916), new Range(122918, 122922), new Single(125255), new Range(127280, 127305), new Range(127312, 127337), new Range(127344, 127369)]);
            
            case OtherDefaultIgnorableCodePoint:
                new Ranges([new Single(847), new Range(4447, 4448), new Range(6068, 6069), new Single(8293), new Single(12644), new Single(65440), new Range(65520, 65528), new Single(917504), new Range(917506, 917535), new Range(917632, 917759), new Range(918000, 921599)]);
            
            case OtherGraphemeExtend:
                new Ranges([new Single(2494), new Single(2519), new Single(2878), new Single(2903), new Single(3006), new Single(3031), new Single(3266), new Range(3285, 3286), new Single(3390), new Single(3415), new Single(3535), new Single(3551), new Single(6965), new Single(8204), new Range(12334, 12335), new Range(65438, 65439), new Single(70462), new Single(70487), new Single(70832), new Single(70845), new Single(71087), new Single(119141), new Range(119150, 119154), new Range(917536, 917631)]);
            
            case OtherIDContinue:
                new Ranges([new Single(183), new Single(903), new Range(4969, 4977), new Single(6618)]);
            
            case OtherIDStart:
                new Ranges([new Range(6277, 6278), new Single(8472), new Single(8494), new Range(12443, 12444)]);
            
            case OtherLowercase:
                new Ranges([new Single(170), new Single(186), new Range(688, 696), new Range(704, 705), new Range(736, 740), new Single(837), new Single(890), new Range(7468, 7530), new Single(7544), new Range(7579, 7615), new Single(8305), new Single(8319), new Range(8336, 8348), new Range(8560, 8575), new Range(9424, 9449), new Range(11388, 11389), new Range(42652, 42653), new Single(42864), new Range(43000, 43001), new Range(43868, 43871)]);
            
            case OtherMath:
                new Ranges([new Single(94), new Range(976, 978), new Single(981), new Range(1008, 1009), new Range(1012, 1013), new Single(8214), new Range(8242, 8244), new Single(8256), new Range(8289, 8292), new Single(8317), new Single(8318), new Single(8333), new Single(8334), new Range(8400, 8412), new Single(8417), new Range(8421, 8422), new Range(8427, 8431), new Single(8450), new Single(8455), new Range(8458, 8467), new Single(8469), new Range(8473, 8477), new Single(8484), new Single(8488), new Single(8489), new Range(8492, 8493), new Range(8495, 8497), new Range(8499, 8500), new Range(8501, 8504), new Range(8508, 8511), new Range(8517, 8521), new Range(8597, 8601), new Range(8604, 8607), new Range(8609, 8610), new Range(8612, 8613), new Single(8615), new Range(8617, 8621), new Range(8624, 8625), new Range(8630, 8631), new Range(8636, 8653), new Range(8656, 8657), new Single(8659), new Range(8661, 8667), new Single(8669), new Range(8676, 8677), new Single(8968), new Single(8969), new Single(8970), new Single(8971), new Range(9140, 9141), new Single(9143), new Single(9168), new Single(9186), new Range(9632, 9633), new Range(9646, 9654), new Range(9660, 9664), new Range(9670, 9671), new Range(9674, 9675), new Range(9679, 9683), new Single(9698), new Single(9700), new Range(9703, 9708), new Range(9733, 9734), new Single(9792), new Single(9794), new Range(9824, 9827), new Range(9837, 9838), new Single(10181), new Single(10182), new Single(10214), new Single(10215), new Single(10216), new Single(10217), new Single(10218), new Single(10219), new Single(10220), new Single(10221), new Single(10222), new Single(10223), new Single(10627), new Single(10628), new Single(10629), new Single(10630), new Single(10631), new Single(10632), new Single(10633), new Single(10634), new Single(10635), new Single(10636), new Single(10637), new Single(10638), new Single(10639), new Single(10640), new Single(10641), new Single(10642), new Single(10643), new Single(10644), new Single(10645), new Single(10646), new Single(10647), new Single(10648), new Single(10712), new Single(10713), new Single(10714), new Single(10715), new Single(10748), new Single(10749), new Single(65121), new Single(65123), new Single(65128), new Single(65340), new Single(65342), new Range(119808, 119892), new Range(119894, 119964), new Range(119966, 119967), new Single(119970), new Range(119973, 119974), new Range(119977, 119980), new Range(119982, 119993), new Single(119995), new Range(119997, 120003), new Range(120005, 120069), new Range(120071, 120074), new Range(120077, 120084), new Range(120086, 120092), new Range(120094, 120121), new Range(120123, 120126), new Range(120128, 120132), new Single(120134), new Range(120138, 120144), new Range(120146, 120485), new Range(120488, 120512), new Range(120514, 120538), new Range(120540, 120570), new Range(120572, 120596), new Range(120598, 120628), new Range(120630, 120654), new Range(120656, 120686), new Range(120688, 120712), new Range(120714, 120744), new Range(120746, 120770), new Range(120772, 120779), new Range(120782, 120831), new Range(126464, 126467), new Range(126469, 126495), new Range(126497, 126498), new Single(126500), new Single(126503), new Range(126505, 126514), new Range(126516, 126519), new Single(126521), new Single(126523), new Single(126530), new Single(126535), new Single(126537), new Single(126539), new Range(126541, 126543), new Range(126545, 126546), new Single(126548), new Single(126551), new Single(126553), new Single(126555), new Single(126557), new Single(126559), new Range(126561, 126562), new Single(126564), new Range(126567, 126570), new Range(126572, 126578), new Range(126580, 126583), new Range(126585, 126588), new Single(126590), new Range(126592, 126601), new Range(126603, 126619), new Range(126625, 126627), new Range(126629, 126633), new Range(126635, 126651)]);
            
            case OtherUppercase:
                new Ranges([new Range(8544, 8559), new Range(9398, 9423), new Range(127280, 127305), new Range(127312, 127337), new Range(127344, 127369)]);
            
            case PatternSyntax:
                new Ranges([new Range(33, 35), new Single(36), new Range(37, 39), new Single(40), new Single(41), new Single(42), new Single(43), new Single(44), new Single(45), new Range(46, 47), new Range(58, 59), new Range(60, 62), new Range(63, 64), new Single(91), new Single(92), new Single(93), new Single(94), new Single(96), new Single(123), new Single(124), new Single(125), new Single(126), new Single(161), new Range(162, 165), new Single(166), new Single(167), new Single(169), new Single(171), new Single(172), new Single(174), new Single(176), new Single(177), new Single(182), new Single(187), new Single(191), new Single(215), new Single(247), new Range(8208, 8213), new Range(8214, 8215), new Single(8216), new Single(8217), new Single(8218), new Range(8219, 8220), new Single(8221), new Single(8222), new Single(8223), new Range(8224, 8231), new Range(8240, 8248), new Single(8249), new Single(8250), new Range(8251, 8254), new Range(8257, 8259), new Single(8260), new Single(8261), new Single(8262), new Range(8263, 8273), new Single(8274), new Single(8275), new Range(8277, 8286), new Range(8592, 8596), new Range(8597, 8601), new Range(8602, 8603), new Range(8604, 8607), new Single(8608), new Range(8609, 8610), new Single(8611), new Range(8612, 8613), new Single(8614), new Range(8615, 8621), new Single(8622), new Range(8623, 8653), new Range(8654, 8655), new Range(8656, 8657), new Single(8658), new Single(8659), new Single(8660), new Range(8661, 8691), new Range(8692, 8959), new Range(8960, 8967), new Single(8968), new Single(8969), new Single(8970), new Single(8971), new Range(8972, 8991), new Range(8992, 8993), new Range(8994, 9000), new Single(9001), new Single(9002), new Range(9003, 9083), new Single(9084), new Range(9085, 9114), new Range(9115, 9139), new Range(9140, 9179), new Range(9180, 9185), new Range(9186, 9254), new Range(9255, 9279), new Range(9280, 9290), new Range(9291, 9311), new Range(9472, 9654), new Single(9655), new Range(9656, 9664), new Single(9665), new Range(9666, 9719), new Range(9720, 9727), new Range(9728, 9838), new Single(9839), new Range(9840, 10087), new Single(10088), new Single(10089), new Single(10090), new Single(10091), new Single(10092), new Single(10093), new Single(10094), new Single(10095), new Single(10096), new Single(10097), new Single(10098), new Single(10099), new Single(10100), new Single(10101), new Range(10132, 10175), new Range(10176, 10180), new Single(10181), new Single(10182), new Range(10183, 10213), new Single(10214), new Single(10215), new Single(10216), new Single(10217), new Single(10218), new Single(10219), new Single(10220), new Single(10221), new Single(10222), new Single(10223), new Range(10224, 10239), new Range(10240, 10495), new Range(10496, 10626), new Single(10627), new Single(10628), new Single(10629), new Single(10630), new Single(10631), new Single(10632), new Single(10633), new Single(10634), new Single(10635), new Single(10636), new Single(10637), new Single(10638), new Single(10639), new Single(10640), new Single(10641), new Single(10642), new Single(10643), new Single(10644), new Single(10645), new Single(10646), new Single(10647), new Single(10648), new Range(10649, 10711), new Single(10712), new Single(10713), new Single(10714), new Single(10715), new Range(10716, 10747), new Single(10748), new Single(10749), new Range(10750, 11007), new Range(11008, 11055), new Range(11056, 11076), new Range(11077, 11078), new Range(11079, 11084), new Range(11085, 11123), new Range(11124, 11125), new Range(11126, 11157), new Range(11158, 11159), new Range(11160, 11263), new Range(11776, 11777), new Single(11778), new Single(11779), new Single(11780), new Single(11781), new Range(11782, 11784), new Single(11785), new Single(11786), new Single(11787), new Single(11788), new Single(11789), new Range(11790, 11798), new Single(11799), new Range(11800, 11801), new Single(11802), new Single(11803), new Single(11804), new Single(11805), new Range(11806, 11807), new Single(11808), new Single(11809), new Single(11810), new Single(11811), new Single(11812), new Single(11813), new Single(11814), new Single(11815), new Single(11816), new Single(11817), new Range(11818, 11822), new Single(11823), new Range(11824, 11833), new Range(11834, 11835), new Range(11836, 11839), new Single(11840), new Single(11841), new Single(11842), new Range(11843, 11855), new Range(11856, 11903), new Range(12289, 12291), new Single(12296), new Single(12297), new Single(12298), new Single(12299), new Single(12300), new Single(12301), new Single(12302), new Single(12303), new Single(12304), new Single(12305), new Range(12306, 12307), new Single(12308), new Single(12309), new Single(12310), new Single(12311), new Single(12312), new Single(12313), new Single(12314), new Single(12315), new Single(12316), new Single(12317), new Range(12318, 12319), new Single(12320), new Single(12336), new Single(64830), new Single(64831), new Range(65093, 65094)]);
            
            case PatternWhiteSpace:
                new Ranges([new Range(9, 13), new Single(32), new Single(133), new Range(8206, 8207), new Single(8232), new Single(8233)]);
            
            case PrependedConcatenationMark:
                new Ranges([new Range(1536, 1541), new Single(1757), new Single(1807), new Single(2274), new Single(69821), new Single(69837)]);
            
            case QuotationMark:
                new Ranges([new Single(34), new Single(39), new Single(171), new Single(187), new Single(8216), new Single(8217), new Single(8218), new Range(8219, 8220), new Single(8221), new Single(8222), new Single(8223), new Single(8249), new Single(8250), new Single(11842), new Single(12300), new Single(12301), new Single(12302), new Single(12303), new Single(12317), new Range(12318, 12319), new Single(65089), new Single(65090), new Single(65091), new Single(65092), new Single(65282), new Single(65287), new Single(65378), new Single(65379)]);
            
            case Radical:
                new Ranges([new Range(11904, 11929), new Range(11931, 12019), new Range(12032, 12245)]);
            
            case RegionalIndicator:
                new Ranges([new Range(127462, 127487)]);
            
            case SentenceTerminal:
                new Ranges([new Single(33), new Single(46), new Single(63), new Single(1417), new Range(1566, 1567), new Single(1748), new Range(1792, 1794), new Single(2041), new Single(2103), new Single(2105), new Range(2109, 2110), new Range(2404, 2405), new Range(4170, 4171), new Single(4962), new Range(4967, 4968), new Single(5742), new Range(5941, 5942), new Single(6147), new Single(6153), new Range(6468, 6469), new Range(6824, 6827), new Range(7002, 7003), new Range(7006, 7007), new Range(7227, 7228), new Range(7294, 7295), new Range(8252, 8253), new Range(8263, 8265), new Single(11822), new Single(11836), new Single(12290), new Single(42239), new Range(42510, 42511), new Single(42739), new Single(42743), new Range(43126, 43127), new Range(43214, 43215), new Single(43311), new Range(43464, 43465), new Range(43613, 43615), new Range(43760, 43761), new Single(44011), new Single(65106), new Range(65110, 65111), new Single(65281), new Single(65294), new Single(65311), new Single(65377), new Range(68182, 68183), new Range(69461, 69465), new Range(69703, 69704), new Range(69822, 69825), new Range(69953, 69955), new Range(70085, 70086), new Single(70093), new Range(70110, 70111), new Range(70200, 70201), new Range(70203, 70204), new Single(70313), new Range(70731, 70732), new Range(71106, 71107), new Range(71113, 71127), new Range(71233, 71234), new Range(71484, 71486), new Range(72258, 72259), new Range(72347, 72348), new Range(72769, 72770), new Range(73463, 73464), new Range(92782, 92783), new Single(92917), new Range(92983, 92984), new Single(92996), new Single(93848), new Single(113823), new Single(121480)]);
            
            case SoftDotted:
                new Ranges([new Range(105, 106), new Single(303), new Single(585), new Single(616), new Single(669), new Single(690), new Single(1011), new Single(1110), new Single(1112), new Single(7522), new Single(7574), new Single(7588), new Single(7592), new Single(7725), new Single(7883), new Single(8305), new Range(8520, 8521), new Single(11388), new Range(119842, 119843), new Range(119894, 119895), new Range(119946, 119947), new Range(119998, 119999), new Range(120050, 120051), new Range(120102, 120103), new Range(120154, 120155), new Range(120206, 120207), new Range(120258, 120259), new Range(120310, 120311), new Range(120362, 120363), new Range(120414, 120415), new Range(120466, 120467)]);
            
            case TerminalPunctuation:
                new Ranges([new Single(33), new Single(44), new Single(46), new Range(58, 59), new Single(63), new Single(894), new Single(903), new Single(1417), new Single(1475), new Single(1548), new Single(1563), new Range(1566, 1567), new Single(1748), new Range(1792, 1802), new Single(1804), new Range(2040, 2041), new Range(2096, 2110), new Single(2142), new Range(2404, 2405), new Range(3674, 3675), new Single(3848), new Range(3853, 3858), new Range(4170, 4171), new Range(4961, 4968), new Single(5742), new Range(5867, 5869), new Range(5941, 5942), new Range(6100, 6102), new Single(6106), new Range(6146, 6149), new Range(6152, 6153), new Range(6468, 6469), new Range(6824, 6827), new Range(7002, 7003), new Range(7005, 7007), new Range(7227, 7231), new Range(7294, 7295), new Range(8252, 8253), new Range(8263, 8265), new Single(11822), new Single(11836), new Single(11841), new Single(11852), new Range(11854, 11855), new Range(12289, 12290), new Range(42238, 42239), new Range(42509, 42511), new Range(42739, 42743), new Range(43126, 43127), new Range(43214, 43215), new Single(43311), new Range(43463, 43465), new Range(43613, 43615), new Single(43743), new Range(43760, 43761), new Single(44011), new Range(65104, 65106), new Range(65108, 65111), new Single(65281), new Single(65292), new Single(65294), new Range(65306, 65307), new Single(65311), new Single(65377), new Single(65380), new Single(66463), new Single(66512), new Single(67671), new Single(67871), new Range(68182, 68183), new Range(68336, 68341), new Range(68410, 68415), new Range(68505, 68508), new Range(69461, 69465), new Range(69703, 69709), new Range(69822, 69825), new Range(69953, 69955), new Range(70085, 70086), new Single(70093), new Range(70110, 70111), new Range(70200, 70204), new Single(70313), new Range(70731, 70733), new Single(70747), new Range(71106, 71109), new Range(71113, 71127), new Range(71233, 71234), new Range(71484, 71486), new Range(72258, 72259), new Range(72347, 72348), new Range(72353, 72354), new Range(72769, 72771), new Single(72817), new Range(73463, 73464), new Range(74864, 74868), new Range(92782, 92783), new Single(92917), new Range(92983, 92985), new Single(92996), new Range(93847, 93848), new Single(113823), new Range(121479, 121482)]);
            
            case UnifiedIdeograph:
                new Ranges([new Range(13312, 19893), new Range(19968, 40943), new Range(64014, 64015), new Single(64017), new Range(64019, 64020), new Single(64031), new Single(64033), new Range(64035, 64036), new Range(64039, 64041), new Range(131072, 173782), new Range(173824, 177972), new Range(177984, 178205), new Range(178208, 183969), new Range(183984, 191456)]);
            
            case VariationSelector:
                new Ranges([new Range(6155, 6157), new Range(65024, 65039), new Range(917760, 917999)]);
            
            case WhiteSpace:
                new Ranges([new Single(32), new Single(133), new Single(160), new Single(5760), new Range(8192, 8202), new Single(8232), new Single(8233), new Single(8239), new Single(8287), new Single(12288)]);
            
            #end
            case _:
                uhx.sys.seri.Ranges.EMPTY;
        }
    }
}