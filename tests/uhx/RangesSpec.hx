package uhx;

import uhx.sys.seri.Range;
import uhx.sys.seri.Ranges;

@:asserts
class RangesSpec {

    public function new() {}

    public function testHas() {
        var rs = new Ranges([new Range(10, 20), 25, 35, new Range(40, 42)]);
        asserts.assert( rs.has(18) );
        asserts.assert( !rs.has(22) );
        asserts.assert( !rs.has(34) );
        asserts.assert( rs.has(35) );
        asserts.assert( rs.has(41) );
        asserts.assert( !rs.has(50) );
        return asserts.done();
    }

    public function testIntersection_simple() {
        var r1 = new Ranges([3, 8]);
        var r2 = new Ranges([1, 3, 7]);
        var i = Ranges.intersection(r1, r2);
        trace( i );
        asserts.assert( !i.has(1) );
        asserts.assert( i.has(3) );
        asserts.assert( !i.has(7) );
        asserts.assert( !i.has(8) );
        return asserts.done();
    }

    public function testIntersection() {
        var a = new Range(10, 26);
        var b = new Range(15, 28);
        var c = new Range(18, 30);
        var d = new Range(22, 35);
        var r1 = new Ranges([a, b]);
        var r2 = new Ranges([c, d]);
        var i1 = Ranges.intersection(r1, r2);
        var i2 = Ranges.intersection(r2, r1);
        
        asserts.assert( i1.min == 22 );
        asserts.assert( i1.max == 26 );
        asserts.assert( i2.min == 22 );
        asserts.assert( i2.max == 26 );
        asserts.assert( i2.min == i1.min );
        asserts.assert( i2.max == i1.max );

        return asserts.done();
    }

    public function testUnion() {
        var r1 = new Ranges([new Range(10, 15), new Range(13, 18), new Range(19,20), 21]);
        var r2 = new Ranges([new Range(14, 11), new Range(9, 12), 18, new Range(8, 18), 4]);
        var u = Ranges.union(r1, r2);

        asserts.assert( u.min == 4 );
        asserts.assert( u.max == 21 );
        asserts.assert( u.values.length == 2 );
        asserts.assert( u.values[0].min == 4 );
        asserts.assert( u.values[0].max == 4 );
        asserts.assert( u.values[1].min == 8 );
        asserts.assert( u.values[1].max == 21 );
        
        return asserts.done();
    }

    public function testComplement() {
        var r = new Ranges([
            new Range(10, 20), 
            new Range(50, 60), 
            new Range(80, 85),
            94,
        ]);
        var c = Ranges.complement(r, 0, 100);
        //trace( c );
        asserts.assert( c.min == 0 );
        asserts.assert( c.max == 100 );
        asserts.assert( c.values.length == 5 );

        asserts.assert( c.values[0].min == 0 );
        asserts.assert( c.values[0].max == 9 );
        asserts.assert( c.values[1].min == 21 );
        asserts.assert( c.values[1].max == 49 );
        asserts.assert( c.values[2].min == 61 );
        asserts.assert( c.values[2].max == 79 );
        asserts.assert( c.values[3].min == 86 );
        asserts.assert( c.values[3].max == 93 );
        asserts.assert( c.values[4].min == 95 );
        asserts.assert( c.values[4].max == 100 );

        return asserts.done();
    }

    public function testAdd() {
        var r = new Ranges([]);
        asserts.assert( r.has(0) == false );
        asserts.assert( r.add(new Range(10, 20)) == true );
        asserts.assert( r.has(10) && r.has(20) );
        asserts.assert( r.values.length == 1 );
        asserts.assert( r.add(19) == false );
        asserts.assert( r.values.length == 1 );
        asserts.assert( r.add(new Range(30, 40)) == true );
        asserts.assert( r.values.length == 2 );
        // 5-9 are not in range, but overlap with an existing `Range`
        // Insert a new `Range`.
        asserts.assert( r.add(new Range(5, 15)) == true );
        asserts.assert( r.values.length == 3 );
        asserts.assert( r.add(new Range(15, 25)) == true );
        asserts.assert( r.values.length == 4 );

        //trace( r );
        return asserts.done();
    }

    public function testRemove() {
        var r = new Ranges([new Range(10, 20)]);

        asserts.assert( r.values.length == 1 );
        asserts.assert( r.remove( 5 ) == false );
        asserts.assert( r.min == 10 );
        asserts.assert( r.max == 20 );
        asserts.assert( r.has(15) == true );
        asserts.assert( r.remove(15) == true );
        asserts.assert( r.values.length == 2 );
        asserts.assert( r.has(15) == false );

        var h = new Range(13, 17);
        asserts.assert( r.has( h.min ) && r.has( h.max ) );
        asserts.assert( r.remove( h ) == true );
        asserts.assert( !r.has( h.min ) && !r.has( h.max ) );

        asserts.assert( r.remove(new Range(10, 20)) == true );
        asserts.assert( r.values.length == 0 );

        return asserts.done();
    }

}