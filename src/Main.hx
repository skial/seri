package ;

import uhx.sys.seri.Ranges;
import uhx.sys.Seri;
import uhx.sys.seri.Unicode;
import uhx.sys.seri.Category;

class Main {

    public static function main() {
        trace( Seri.getCategory( Category.Pf ) );
        var ranges:Ranges = Category.Pf;
        trace( ranges.min, ranges.max );

        for (range in ranges) trace( range );
        trace( Seri.version );
    }

}