package ;

import tink.unit.TestBatch;
import tink.testrunner.Runner;

class Entry {

    public static function main() {
        Runner.run(TestBatch.make([
            new uhx.RangeSpec(),
            new uhx.RangesSpec(),
        ])).handle( Runner.exit );
    }

}