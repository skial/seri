package uhx.sys.seri.builder;

import haxe.macro.Context;

@:forward enum abstract Defines(String) from String to String {

    public var Save = 'save';
    public var Debug = 'debug';
    public var DryRun = 'dryrun';
    public var Version = 'seri.version';
    public var Resource = 'seri.resource';
    public var Display = 'display';

    @:to public inline function defined():Bool {
        return Context.defined(this);
    }

    public inline function get():Null<String> {
        return Context.definedValue(this);
    }

    @:op(!A) static inline function not(a:Defines):Bool {
        return !a.defined();
    }

    @:commutative @:op(A && B) static inline function and(a:Defines, b:Bool):Bool {
        return a.defined() && b;
    }

}