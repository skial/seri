package uhx.sys.seri.v1510;

/**
    This file has been auto-generated. Do NOT edit.
**/

import uhx.sys.seri.*;

@:unicode("15.1.0")
enum abstract PropList(String) to String {
    
    public var AsciiHexDigit = "ASCII_Hex_Digit";
    public var BidiControl = "Bidi_Control";
    public var Dash = "Dash";
    public var Deprecated = "Deprecated";
    public var Diacritic = "Diacritic";
    public var Extender = "Extender";
    public var HexDigit = "Hex_Digit";
    public var Hyphen = "Hyphen";
    public var IDCompatMathContinue = "ID_Compat_Math_Continue";
    public var IDCompatMathStart = "ID_Compat_Math_Start";
    public var IDSBinaryOperator = "IDS_Binary_Operator";
    public var IDSTrinaryOperator = "IDS_Trinary_Operator";
    public var IDSUnaryOperator = "IDS_Unary_Operator";
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
        IDCompatMathContinue, 
        IDCompatMathStart, 
        IDSBinaryOperator, 
        IDSTrinaryOperator, 
        IDSUnaryOperator, 
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
            
            case "AsciiHexDigit":
                new Ranges([new Range(48, 57), new Range(65, 70), new Range(97, 102)]);
            
            case "BidiControl":
                new Ranges([1564, new Range(8206, 8207), new Range(8234, 8238), new Range(8294, 8297)]);
            
            case "Dash":
                new Ranges([45, 1418, 1470, 5120, 6150, new Range(8208, 8213), 8275, 8315, 8331, 8722, 11799, 11802, new Range(11834, 11835), 11840, 11869, 12316, 12336, 12448, new Range(65073, 65074), 65112, 65123, 65293, 69293]);
            
            case "Deprecated":
                new Ranges([329, 1651, 3959, 3961, new Range(6051, 6052), new Range(8298, 8303), 9001, 9002, 917505]);
            
            case "Diacritic":
                new Ranges([94, 96, 168, 175, 180, 183, 184, new Range(688, 705), new Range(706, 709), new Range(710, 721), new Range(722, 735), new Range(736, 740), new Range(741, 747), 748, 749, 750, new Range(751, 767), new Range(768, 846), new Range(848, 855), new Range(861, 866), 884, 885, 890, new Range(900, 901), new Range(1155, 1159), 1369, new Range(1425, 1441), new Range(1443, 1469), 1471, new Range(1473, 1474), 1476, new Range(1611, 1618), new Range(1623, 1624), new Range(1759, 1760), new Range(1765, 1766), new Range(1770, 1772), new Range(1840, 1866), new Range(1958, 1968), new Range(2027, 2035), new Range(2036, 2037), new Range(2072, 2073), new Range(2200, 2207), 2249, new Range(2250, 2258), new Range(2275, 2302), 2364, 2381, new Range(2385, 2388), 2417, 2492, 2509, 2620, 2637, 2748, 2765, new Range(2813, 2815), 2876, 2893, 2901, 3021, 3132, 3149, 3260, 3277, new Range(3387, 3388), 3405, 3530, new Range(3655, 3660), 3662, 3770, new Range(3784, 3788), new Range(3864, 3865), 3893, 3895, 3897, new Range(3902, 3903), new Range(3970, 3972), new Range(3974, 3975), 4038, 4151, new Range(4153, 4154), new Range(4195, 4196), new Range(4201, 4205), new Range(4231, 4236), 4237, 4239, new Range(4250, 4251), new Range(4957, 4959), 5908, 5909, new Range(6089, 6099), 6109, new Range(6457, 6459), new Range(6773, 6780), 6783, new Range(6832, 6845), 6846, new Range(6849, 6859), 6964, 6980, new Range(7019, 7027), 7082, 7083, new Range(7222, 7223), new Range(7288, 7293), new Range(7376, 7378), 7379, new Range(7380, 7392), 7393, new Range(7394, 7400), 7405, 7412, 7415, new Range(7416, 7417), new Range(7468, 7530), new Range(7620, 7631), new Range(7669, 7679), 8125, new Range(8127, 8129), new Range(8141, 8143), new Range(8157, 8159), new Range(8173, 8175), new Range(8189, 8190), new Range(11503, 11505), 11823, new Range(12330, 12333), new Range(12334, 12335), new Range(12441, 12442), new Range(12443, 12444), 12540, 42607, new Range(42620, 42621), 42623, new Range(42652, 42653), new Range(42736, 42737), new Range(42752, 42774), new Range(42775, 42783), new Range(42784, 42785), 42888, new Range(42889, 42890), new Range(43000, 43001), 43204, new Range(43232, 43249), new Range(43307, 43309), 43310, 43347, 43443, 43456, 43493, 43643, 43644, 43645, 43711, 43712, 43713, 43714, 43766, 43867, new Range(43868, 43871), 43881, new Range(43882, 43883), 44012, 44013, 64286, new Range(65056, 65071), 65342, 65344, 65392, new Range(65438, 65439), 65507, 66272, new Range(67456, 67461), new Range(67463, 67504), new Range(67506, 67514), new Range(68325, 68326), new Range(68898, 68899), new Range(68900, 68903), new Range(69373, 69375), new Range(69446, 69456), new Range(69506, 69509), 69702, 69744, new Range(69817, 69818), new Range(69939, 69940), 70003, 70080, new Range(70090, 70092), 70197, 70198, new Range(70377, 70378), 70460, 70477, new Range(70502, 70508), new Range(70512, 70516), 70722, 70726, new Range(70850, 70851), new Range(71103, 71104), 71231, 71350, 71351, 71467, new Range(71737, 71738), 71997, 71998, 72003, 72160, 72244, 72263, 72345, 72767, 73026, new Range(73028, 73029), 73111, new Range(78919, 78933), new Range(92912, 92916), new Range(92976, 92982), new Range(94095, 94098), new Range(94099, 94111), new Range(94192, 94193), new Range(110576, 110579), new Range(110581, 110587), new Range(110589, 110590), new Range(118528, 118573), new Range(118576, 118598), new Range(119143, 119145), new Range(119149, 119154), new Range(119163, 119170), new Range(119173, 119179), new Range(119210, 119213), new Range(122928, 122989), new Range(123184, 123190), 123566, new Range(123628, 123631), new Range(125136, 125142), new Range(125252, 125254), new Range(125256, 125258)]);
            
            case "Extender":
                new Ranges([183, new Range(720, 721), 1600, 2042, 2901, 3654, 3782, 6154, 6211, 6823, 7222, 7291, 12293, new Range(12337, 12341), new Range(12445, 12446), new Range(12540, 12542), 40981, 42508, 43471, 43494, 43632, 43741, new Range(43763, 43764), 65392, new Range(67457, 67458), 70493, new Range(71110, 71112), 72344, new Range(92994, 92995), new Range(94176, 94177), 94179, new Range(123196, 123197), new Range(125252, 125254)]);
            
            case "HexDigit":
                new Ranges([new Range(48, 57), new Range(65, 70), new Range(97, 102), new Range(65296, 65305), new Range(65313, 65318), new Range(65345, 65350)]);
            
            case "Hyphen":
                new Ranges([45, 173, 1418, 6150, new Range(8208, 8209), 11799, 12539, 65123, 65293, 65381]);
            
            case "IDCompatMathContinue":
                new Ranges([new Range(178, 179), 185, 8304, new Range(8308, 8313), new Range(8314, 8316), 8317, 8318, new Range(8320, 8329), new Range(8330, 8332), 8333, 8334, 8706, 8711, 8734, 120513, 120539, 120571, 120597, 120629, 120655, 120687, 120713, 120745, 120771]);
            
            case "IDCompatMathStart":
                new Ranges([8706, 8711, 8734, 120513, 120539, 120571, 120597, 120629, 120655, 120687, 120713, 120745, 120771]);
            
            case "IDSBinaryOperator":
                new Ranges([new Range(12272, 12273), new Range(12276, 12285), 12783]);
            
            case "IDSTrinaryOperator":
                new Ranges([new Range(12274, 12275)]);
            
            case "IDSUnaryOperator":
                new Ranges([new Range(12286, 12287)]);
            
            case "Ideographic":
                new Ranges([12294, 12295, new Range(12321, 12329), new Range(12344, 12346), new Range(13312, 19903), new Range(19968, 40959), new Range(63744, 64109), new Range(64112, 64217), 94180, new Range(94208, 100343), new Range(100352, 101589), new Range(101632, 101640), new Range(110960, 111355), new Range(131072, 173791), new Range(173824, 177977), new Range(177984, 178205), new Range(178208, 183969), new Range(183984, 191456), new Range(194560, 195101), new Range(196608, 201546), new Range(201552, 205743)]);
            
            case "JoinControl":
                new Ranges([new Range(8204, 8205)]);
            
            case "LogicalOrderException":
                new Ranges([new Range(3648, 3652), new Range(3776, 3780), new Range(6581, 6583), 6586, new Range(43701, 43702), 43705, new Range(43707, 43708)]);
            
            case "NoncharacterCodePoint":
                new Ranges([new Range(64976, 65007), new Range(65534, 65535), new Range(131070, 131071), new Range(196606, 196607), new Range(262142, 262143), new Range(327678, 327679), new Range(393214, 393215), new Range(458750, 458751), new Range(524286, 524287), new Range(589822, 589823), new Range(655358, 655359), new Range(720894, 720895), new Range(786430, 786431), new Range(851966, 851967), new Range(917502, 917503), new Range(983038, 983039), new Range(1048574, 1048575), new Range(1114110, 1114111)]);
            
            case "OtherAlphabetic":
                new Ranges([837, new Range(1456, 1469), 1471, new Range(1473, 1474), new Range(1476, 1477), 1479, new Range(1552, 1562), new Range(1611, 1623), new Range(1625, 1631), 1648, new Range(1750, 1756), new Range(1761, 1764), new Range(1767, 1768), 1773, 1809, new Range(1840, 1855), new Range(1958, 1968), new Range(2070, 2071), new Range(2075, 2083), new Range(2085, 2087), new Range(2089, 2092), new Range(2260, 2271), new Range(2275, 2281), new Range(2288, 2306), 2307, 2362, 2363, new Range(2366, 2368), new Range(2369, 2376), new Range(2377, 2380), new Range(2382, 2383), new Range(2389, 2391), new Range(2402, 2403), 2433, new Range(2434, 2435), new Range(2494, 2496), new Range(2497, 2500), new Range(2503, 2504), new Range(2507, 2508), 2519, new Range(2530, 2531), new Range(2561, 2562), 2563, new Range(2622, 2624), new Range(2625, 2626), new Range(2631, 2632), new Range(2635, 2636), 2641, new Range(2672, 2673), 2677, new Range(2689, 2690), 2691, new Range(2750, 2752), new Range(2753, 2757), new Range(2759, 2760), 2761, new Range(2763, 2764), new Range(2786, 2787), new Range(2810, 2812), 2817, new Range(2818, 2819), 2878, 2879, 2880, new Range(2881, 2884), new Range(2887, 2888), new Range(2891, 2892), 2902, 2903, new Range(2914, 2915), 2946, new Range(3006, 3007), 3008, new Range(3009, 3010), new Range(3014, 3016), new Range(3018, 3020), 3031, 3072, new Range(3073, 3075), 3076, new Range(3134, 3136), new Range(3137, 3140), new Range(3142, 3144), new Range(3146, 3148), new Range(3157, 3158), new Range(3170, 3171), 3201, new Range(3202, 3203), 3262, 3263, new Range(3264, 3268), 3270, new Range(3271, 3272), new Range(3274, 3275), 3276, new Range(3285, 3286), new Range(3298, 3299), 3315, new Range(3328, 3329), new Range(3330, 3331), new Range(3390, 3392), new Range(3393, 3396), new Range(3398, 3400), new Range(3402, 3404), 3415, new Range(3426, 3427), 3457, new Range(3458, 3459), new Range(3535, 3537), new Range(3538, 3540), 3542, new Range(3544, 3551), new Range(3570, 3571), 3633, new Range(3636, 3642), 3661, 3761, new Range(3764, 3769), new Range(3771, 3772), 3789, new Range(3953, 3966), 3967, new Range(3968, 3971), new Range(3981, 3991), new Range(3993, 4028), new Range(4139, 4140), new Range(4141, 4144), 4145, new Range(4146, 4150), 4152, new Range(4155, 4156), new Range(4157, 4158), new Range(4182, 4183), new Range(4184, 4185), new Range(4190, 4192), new Range(4194, 4196), new Range(4199, 4205), new Range(4209, 4212), 4226, new Range(4227, 4228), new Range(4229, 4230), new Range(4231, 4236), 4237, 4239, new Range(4250, 4252), 4253, new Range(5906, 5907), new Range(5938, 5939), new Range(5970, 5971), new Range(6002, 6003), 6070, new Range(6071, 6077), new Range(6078, 6085), 6086, new Range(6087, 6088), new Range(6277, 6278), 6313, new Range(6432, 6434), new Range(6435, 6438), new Range(6439, 6440), new Range(6441, 6443), new Range(6448, 6449), 6450, new Range(6451, 6456), new Range(6679, 6680), new Range(6681, 6682), 6683, 6741, 6742, 6743, new Range(6744, 6750), 6753, 6754, new Range(6755, 6756), new Range(6757, 6764), new Range(6765, 6770), new Range(6771, 6772), new Range(6847, 6848), new Range(6860, 6862), new Range(6912, 6915), 6916, 6965, new Range(6966, 6970), 6971, 6972, new Range(6973, 6977), 6978, 6979, new Range(7040, 7041), 7042, 7073, new Range(7074, 7077), new Range(7078, 7079), new Range(7080, 7081), new Range(7084, 7085), 7143, new Range(7144, 7145), new Range(7146, 7148), 7149, 7150, new Range(7151, 7153), new Range(7204, 7211), new Range(7212, 7219), new Range(7220, 7221), 7222, new Range(7655, 7668), new Range(9398, 9449), new Range(11744, 11775), new Range(42612, 42619), new Range(42654, 42655), 43010, 43019, new Range(43043, 43044), new Range(43045, 43046), 43047, new Range(43136, 43137), new Range(43188, 43203), 43205, 43263, new Range(43302, 43306), new Range(43335, 43345), 43346, new Range(43392, 43394), 43395, new Range(43444, 43445), new Range(43446, 43449), new Range(43450, 43451), new Range(43452, 43453), new Range(43454, 43455), 43493, new Range(43561, 43566), new Range(43567, 43568), new Range(43569, 43570), new Range(43571, 43572), new Range(43573, 43574), 43587, 43596, 43597, 43643, 43644, 43645, 43696, new Range(43698, 43700), new Range(43703, 43704), 43710, 43755, new Range(43756, 43757), new Range(43758, 43759), 43765, new Range(44003, 44004), 44005, new Range(44006, 44007), 44008, new Range(44009, 44010), 64286, new Range(66422, 66426), new Range(68097, 68099), new Range(68101, 68102), new Range(68108, 68111), new Range(68900, 68903), new Range(69291, 69292), 69632, 69633, 69634, new Range(69688, 69701), new Range(69747, 69748), new Range(69760, 69761), 69762, new Range(69808, 69810), new Range(69811, 69814), new Range(69815, 69816), 69826, new Range(69888, 69890), new Range(69927, 69931), 69932, new Range(69933, 69938), new Range(69957, 69958), new Range(70016, 70017), 70018, new Range(70067, 70069), new Range(70070, 70078), 70079, 70094, 70095, new Range(70188, 70190), new Range(70191, 70193), new Range(70194, 70195), 70196, 70199, 70206, 70209, 70367, new Range(70368, 70370), new Range(70371, 70376), new Range(70400, 70401), new Range(70402, 70403), new Range(70462, 70463), 70464, new Range(70465, 70468), new Range(70471, 70472), new Range(70475, 70476), 70487, new Range(70498, 70499), new Range(70709, 70711), new Range(70712, 70719), new Range(70720, 70721), new Range(70723, 70724), 70725, new Range(70832, 70834), new Range(70835, 70840), 70841, 70842, new Range(70843, 70846), new Range(70847, 70848), 70849, new Range(71087, 71089), new Range(71090, 71093), new Range(71096, 71099), new Range(71100, 71101), 71102, new Range(71132, 71133), new Range(71216, 71218), new Range(71219, 71226), new Range(71227, 71228), 71229, 71230, 71232, 71339, 71340, 71341, new Range(71342, 71343), new Range(71344, 71349), new Range(71453, 71455), new Range(71456, 71457), new Range(71458, 71461), 71462, new Range(71463, 71466), new Range(71724, 71726), new Range(71727, 71735), 71736, new Range(71984, 71989), new Range(71991, 71992), new Range(71995, 71996), 72000, 72002, new Range(72145, 72147), new Range(72148, 72151), new Range(72154, 72155), new Range(72156, 72159), 72164, new Range(72193, 72202), new Range(72245, 72248), 72249, new Range(72251, 72254), new Range(72273, 72278), new Range(72279, 72280), new Range(72281, 72283), new Range(72330, 72342), 72343, 72751, new Range(72752, 72758), new Range(72760, 72765), 72766, new Range(72850, 72871), 72873, new Range(72874, 72880), 72881, new Range(72882, 72883), 72884, new Range(72885, 72886), new Range(73009, 73014), 73018, new Range(73020, 73021), new Range(73023, 73025), 73027, 73031, new Range(73098, 73102), new Range(73104, 73105), new Range(73107, 73108), 73109, 73110, new Range(73459, 73460), new Range(73461, 73462), new Range(73472, 73473), 73475, new Range(73524, 73525), new Range(73526, 73530), new Range(73534, 73535), 73536, 94031, new Range(94033, 94087), new Range(94095, 94098), new Range(94192, 94193), 113822, new Range(122880, 122886), new Range(122888, 122904), new Range(122907, 122913), new Range(122915, 122916), new Range(122918, 122922), 123023, 125255, new Range(127280, 127305), new Range(127312, 127337), new Range(127344, 127369)]);
            
            case "OtherDefaultIgnorableCodePoint":
                new Ranges([847, new Range(4447, 4448), new Range(6068, 6069), 8293, 12644, 65440, new Range(65520, 65528), 917504, new Range(917506, 917535), new Range(917632, 917759), new Range(918000, 921599)]);
            
            case "OtherGraphemeExtend":
                new Ranges([2494, 2519, 2878, 2903, 3006, 3031, 3266, new Range(3285, 3286), 3390, 3415, 3535, 3551, 6965, 8204, new Range(12334, 12335), new Range(65438, 65439), 70462, 70487, 70832, 70845, 71087, 71984, 119141, new Range(119150, 119154), new Range(917536, 917631)]);
            
            case "OtherIDContinue":
                new Ranges([183, 903, new Range(4969, 4977), 6618, new Range(8204, 8205)]);
            
            case "OtherIDStart":
                new Ranges([new Range(6277, 6278), 8472, 8494, new Range(12443, 12444)]);
            
            case "OtherLowercase":
                new Ranges([170, 186, new Range(688, 696), new Range(704, 705), new Range(736, 740), 837, 890, 4348, new Range(7468, 7530), 7544, new Range(7579, 7615), 8305, 8319, new Range(8336, 8348), new Range(8560, 8575), new Range(9424, 9449), new Range(11388, 11389), new Range(42652, 42653), 42864, new Range(42994, 42996), new Range(43000, 43001), new Range(43868, 43871), 43881, 67456, new Range(67459, 67461), new Range(67463, 67504), new Range(67506, 67514), new Range(122928, 122989)]);
            
            case "OtherMath":
                new Ranges([94, new Range(976, 978), 981, new Range(1008, 1009), new Range(1012, 1013), 8214, new Range(8242, 8244), 8256, new Range(8289, 8292), 8317, 8318, 8333, 8334, new Range(8400, 8412), 8417, new Range(8421, 8422), new Range(8427, 8431), 8450, 8455, new Range(8458, 8467), 8469, new Range(8473, 8477), 8484, 8488, 8489, new Range(8492, 8493), new Range(8495, 8497), new Range(8499, 8500), new Range(8501, 8504), new Range(8508, 8511), new Range(8517, 8521), new Range(8597, 8601), new Range(8604, 8607), new Range(8609, 8610), new Range(8612, 8613), 8615, new Range(8617, 8621), new Range(8624, 8625), new Range(8630, 8631), new Range(8636, 8653), new Range(8656, 8657), 8659, new Range(8661, 8667), 8669, new Range(8676, 8677), 8968, 8969, 8970, 8971, new Range(9140, 9141), 9143, 9168, 9186, new Range(9632, 9633), new Range(9646, 9654), new Range(9660, 9664), new Range(9670, 9671), new Range(9674, 9675), new Range(9679, 9683), 9698, 9700, new Range(9703, 9708), new Range(9733, 9734), 9792, 9794, new Range(9824, 9827), new Range(9837, 9838), 10181, 10182, 10214, 10215, 10216, 10217, 10218, 10219, 10220, 10221, 10222, 10223, 10627, 10628, 10629, 10630, 10631, 10632, 10633, 10634, 10635, 10636, 10637, 10638, 10639, 10640, 10641, 10642, 10643, 10644, 10645, 10646, 10647, 10648, 10712, 10713, 10714, 10715, 10748, 10749, 65121, 65123, 65128, 65340, 65342, new Range(119808, 119892), new Range(119894, 119964), new Range(119966, 119967), 119970, new Range(119973, 119974), new Range(119977, 119980), new Range(119982, 119993), 119995, new Range(119997, 120003), new Range(120005, 120069), new Range(120071, 120074), new Range(120077, 120084), new Range(120086, 120092), new Range(120094, 120121), new Range(120123, 120126), new Range(120128, 120132), 120134, new Range(120138, 120144), new Range(120146, 120485), new Range(120488, 120512), new Range(120514, 120538), new Range(120540, 120570), new Range(120572, 120596), new Range(120598, 120628), new Range(120630, 120654), new Range(120656, 120686), new Range(120688, 120712), new Range(120714, 120744), new Range(120746, 120770), new Range(120772, 120779), new Range(120782, 120831), new Range(126464, 126467), new Range(126469, 126495), new Range(126497, 126498), 126500, 126503, new Range(126505, 126514), new Range(126516, 126519), 126521, 126523, 126530, 126535, 126537, 126539, new Range(126541, 126543), new Range(126545, 126546), 126548, 126551, 126553, 126555, 126557, 126559, new Range(126561, 126562), 126564, new Range(126567, 126570), new Range(126572, 126578), new Range(126580, 126583), new Range(126585, 126588), 126590, new Range(126592, 126601), new Range(126603, 126619), new Range(126625, 126627), new Range(126629, 126633), new Range(126635, 126651)]);
            
            case "OtherUppercase":
                new Ranges([new Range(8544, 8559), new Range(9398, 9423), new Range(127280, 127305), new Range(127312, 127337), new Range(127344, 127369)]);
            
            case "PatternSyntax":
                new Ranges([new Range(33, 35), 36, new Range(37, 39), 40, 41, 42, 43, 44, 45, new Range(46, 47), new Range(58, 59), new Range(60, 62), new Range(63, 64), 91, 92, 93, 94, 96, 123, 124, 125, 126, 161, new Range(162, 165), 166, 167, 169, 171, 172, 174, 176, 177, 182, 187, 191, 215, 247, new Range(8208, 8213), new Range(8214, 8215), 8216, 8217, 8218, new Range(8219, 8220), 8221, 8222, 8223, new Range(8224, 8231), new Range(8240, 8248), 8249, 8250, new Range(8251, 8254), new Range(8257, 8259), 8260, 8261, 8262, new Range(8263, 8273), 8274, 8275, new Range(8277, 8286), new Range(8592, 8596), new Range(8597, 8601), new Range(8602, 8603), new Range(8604, 8607), 8608, new Range(8609, 8610), 8611, new Range(8612, 8613), 8614, new Range(8615, 8621), 8622, new Range(8623, 8653), new Range(8654, 8655), new Range(8656, 8657), 8658, 8659, 8660, new Range(8661, 8691), new Range(8692, 8959), new Range(8960, 8967), 8968, 8969, 8970, 8971, new Range(8972, 8991), new Range(8992, 8993), new Range(8994, 9000), 9001, 9002, new Range(9003, 9083), 9084, new Range(9085, 9114), new Range(9115, 9139), new Range(9140, 9179), new Range(9180, 9185), new Range(9186, 9254), new Range(9255, 9279), new Range(9280, 9290), new Range(9291, 9311), new Range(9472, 9654), 9655, new Range(9656, 9664), 9665, new Range(9666, 9719), new Range(9720, 9727), new Range(9728, 9838), 9839, new Range(9840, 10087), 10088, 10089, 10090, 10091, 10092, 10093, 10094, 10095, 10096, 10097, 10098, 10099, 10100, 10101, new Range(10132, 10175), new Range(10176, 10180), 10181, 10182, new Range(10183, 10213), 10214, 10215, 10216, 10217, 10218, 10219, 10220, 10221, 10222, 10223, new Range(10224, 10239), new Range(10240, 10495), new Range(10496, 10626), 10627, 10628, 10629, 10630, 10631, 10632, 10633, 10634, 10635, 10636, 10637, 10638, 10639, 10640, 10641, 10642, 10643, 10644, 10645, 10646, 10647, 10648, new Range(10649, 10711), 10712, 10713, 10714, 10715, new Range(10716, 10747), 10748, 10749, new Range(10750, 11007), new Range(11008, 11055), new Range(11056, 11076), new Range(11077, 11078), new Range(11079, 11084), new Range(11085, 11123), new Range(11124, 11125), new Range(11126, 11157), 11158, new Range(11159, 11263), new Range(11776, 11777), 11778, 11779, 11780, 11781, new Range(11782, 11784), 11785, 11786, 11787, 11788, 11789, new Range(11790, 11798), 11799, new Range(11800, 11801), 11802, 11803, 11804, 11805, new Range(11806, 11807), 11808, 11809, 11810, 11811, 11812, 11813, 11814, 11815, 11816, 11817, new Range(11818, 11822), 11823, new Range(11824, 11833), new Range(11834, 11835), new Range(11836, 11839), 11840, 11841, 11842, new Range(11843, 11855), new Range(11856, 11857), new Range(11858, 11860), 11861, 11862, 11863, 11864, 11865, 11866, 11867, 11868, 11869, new Range(11870, 11903), new Range(12289, 12291), 12296, 12297, 12298, 12299, 12300, 12301, 12302, 12303, 12304, 12305, new Range(12306, 12307), 12308, 12309, 12310, 12311, 12312, 12313, 12314, 12315, 12316, 12317, new Range(12318, 12319), 12320, 12336, 64830, 64831, new Range(65093, 65094)]);
            
            case "PatternWhiteSpace":
                new Ranges([new Range(9, 13), 32, 133, new Range(8206, 8207), 8232, 8233]);
            
            case "PrependedConcatenationMark":
                new Ranges([new Range(1536, 1541), 1757, 1807, new Range(2192, 2193), 2274, 69821, 69837]);
            
            case "QuotationMark":
                new Ranges([34, 39, 171, 187, 8216, 8217, 8218, new Range(8219, 8220), 8221, 8222, 8223, 8249, 8250, 11842, 12300, 12301, 12302, 12303, 12317, new Range(12318, 12319), 65089, 65090, 65091, 65092, 65282, 65287, 65378, 65379]);
            
            case "Radical":
                new Ranges([new Range(11904, 11929), new Range(11931, 12019), new Range(12032, 12245)]);
            
            case "RegionalIndicator":
                new Ranges([new Range(127462, 127487)]);
            
            case "SentenceTerminal":
                new Ranges([33, 46, 63, 1417, new Range(1565, 1567), 1748, new Range(1792, 1794), 2041, 2103, 2105, new Range(2109, 2110), new Range(2404, 2405), new Range(4170, 4171), 4962, new Range(4967, 4968), 5742, new Range(5941, 5942), 6147, 6153, new Range(6468, 6469), new Range(6824, 6827), new Range(7002, 7003), new Range(7006, 7007), new Range(7037, 7038), new Range(7227, 7228), new Range(7294, 7295), new Range(8252, 8253), new Range(8263, 8265), 11822, 11836, new Range(11859, 11860), 12290, 42239, new Range(42510, 42511), 42739, 42743, new Range(43126, 43127), new Range(43214, 43215), 43311, new Range(43464, 43465), new Range(43613, 43615), new Range(43760, 43761), 44011, 65106, new Range(65110, 65111), 65281, 65294, 65311, 65377, new Range(68182, 68183), new Range(69461, 69465), new Range(69510, 69513), new Range(69703, 69704), new Range(69822, 69825), new Range(69953, 69955), new Range(70085, 70086), 70093, new Range(70110, 70111), new Range(70200, 70201), new Range(70203, 70204), 70313, new Range(70731, 70732), new Range(71106, 71107), new Range(71113, 71127), new Range(71233, 71234), new Range(71484, 71486), 72004, 72006, new Range(72258, 72259), new Range(72347, 72348), new Range(72769, 72770), new Range(73463, 73464), new Range(73539, 73540), new Range(92782, 92783), 92917, new Range(92983, 92984), 92996, 93848, 113823, 121480]);
            
            case "SoftDotted":
                new Ranges([new Range(105, 106), 303, 585, 616, 669, 690, 1011, 1110, 1112, 7522, 7574, 7588, 7592, 7725, 7883, 8305, new Range(8520, 8521), 11388, new Range(119842, 119843), new Range(119894, 119895), new Range(119946, 119947), new Range(119998, 119999), new Range(120050, 120051), new Range(120102, 120103), new Range(120154, 120155), new Range(120206, 120207), new Range(120258, 120259), new Range(120310, 120311), new Range(120362, 120363), new Range(120414, 120415), new Range(120466, 120467), 122650, new Range(122956, 122957), 122984]);
            
            case "TerminalPunctuation":
                new Ranges([33, 44, 46, new Range(58, 59), 63, 894, 903, 1417, 1475, 1548, 1563, new Range(1565, 1567), 1748, new Range(1792, 1802), 1804, new Range(2040, 2041), new Range(2096, 2110), 2142, new Range(2404, 2405), new Range(3674, 3675), 3848, new Range(3853, 3858), new Range(4170, 4171), new Range(4961, 4968), 5742, new Range(5867, 5869), new Range(5941, 5942), new Range(6100, 6102), 6106, new Range(6146, 6149), new Range(6152, 6153), new Range(6468, 6469), new Range(6824, 6827), new Range(7002, 7003), new Range(7005, 7007), new Range(7037, 7038), new Range(7227, 7231), new Range(7294, 7295), new Range(8252, 8253), new Range(8263, 8265), 11822, 11836, 11841, 11852, new Range(11854, 11855), new Range(11859, 11860), new Range(12289, 12290), new Range(42238, 42239), new Range(42509, 42511), new Range(42739, 42743), new Range(43126, 43127), new Range(43214, 43215), 43311, new Range(43463, 43465), new Range(43613, 43615), 43743, new Range(43760, 43761), 44011, new Range(65104, 65106), new Range(65108, 65111), 65281, 65292, 65294, new Range(65306, 65307), 65311, 65377, 65380, 66463, 66512, 67671, 67871, new Range(68182, 68183), new Range(68336, 68341), new Range(68410, 68415), new Range(68505, 68508), new Range(69461, 69465), new Range(69510, 69513), new Range(69703, 69709), new Range(69822, 69825), new Range(69953, 69955), new Range(70085, 70086), 70093, new Range(70110, 70111), new Range(70200, 70204), 70313, new Range(70731, 70733), new Range(70746, 70747), new Range(71106, 71109), new Range(71113, 71127), new Range(71233, 71234), new Range(71484, 71486), 72004, 72006, new Range(72258, 72259), new Range(72347, 72348), new Range(72353, 72354), new Range(72769, 72771), 72817, new Range(73463, 73464), new Range(73539, 73540), new Range(74864, 74868), new Range(92782, 92783), 92917, new Range(92983, 92985), 92996, new Range(93847, 93848), 113823, new Range(121479, 121482)]);
            
            case "UnifiedIdeograph":
                new Ranges([new Range(13312, 19903), new Range(19968, 40959), new Range(64014, 64015), 64017, new Range(64019, 64020), 64031, 64033, new Range(64035, 64036), new Range(64039, 64041), new Range(131072, 173791), new Range(173824, 177977), new Range(177984, 178205), new Range(178208, 183969), new Range(183984, 191456), new Range(196608, 201546), new Range(201552, 205743)]);
            
            case "VariationSelector":
                new Ranges([new Range(6155, 6157), 6159, new Range(65024, 65039), new Range(917760, 917999)]);
            
            case "WhiteSpace":
                new Ranges([32, 133, 160, 5760, new Range(8192, 8202), 8232, 8233, 8239, 8287, 12288]);
            
            #end
            case _:
                uhx.sys.seri.Ranges.EMPTY;
        }
    }
}