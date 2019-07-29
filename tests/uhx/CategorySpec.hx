package uhx;

import uhx.sys.seri.Ranges;
import uhx.sys.seri.Category;

@:asserts class CategorySpec {

    public inline function new() {}

    public function basic() {
        var cc = Cc;
        var rs:Ranges = cc;
        
        asserts.assert( cc == 'Cc' );
        asserts.assert( rs.min == 0 );
        asserts.assert( rs.max == 159 );

        return asserts.done();
    }

}