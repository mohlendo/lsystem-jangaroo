package lsystem {
import flexunit.framework.TestSuite;

import lsystem.parser.RulesParserTest;

import lsystem.parser.ScannerTest;

public class TestSuite {
   public static function suite():flexunit.framework.TestSuite {

    var suite:flexunit.framework.TestSuite = new flexunit.framework.TestSuite(ScannerTest);
     suite.addTestSuite(RulesParserTest);
    return suite;
  }
}
}