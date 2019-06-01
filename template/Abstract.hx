package uhx.sys.seri.v::pack::;

/**
    This file has been auto-generated. Do NOT edit.
**/

import uhx.sys.seri.*;

@:unicode("::version::")
enum abstract ::typeName::(String) {
    ::foreach fields::
    ::if define:: #if ::define:: ::end::public var ::ident:: = "::value::";::if define:: #end ::end::::end::

    public static inline function all():Array<::typeName::> return [::foreach fields::
        ::if define::#if ::define::::end::::ident::, ::if define::#end::end::::end::
    ];

    @:to public inline function asRange():::rangeType:: {
        return switch this {
            #if !display
            ::foreach fields::
            ::if define::#if ::define::::end::case ::ident:::
                ::range::;
            ::if define::#end::end::::end::
            #end
            case _:
                ::rangeType::.EMPTY;
        }
    }
}