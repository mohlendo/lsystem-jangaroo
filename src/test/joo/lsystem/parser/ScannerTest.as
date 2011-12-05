package lsystem.parser {
import flexunit.framework.TestCase;

public class ScannerTest extends TestCase {
  private var scanner:Scanner;

  public function testNextToken():void {
    var source:String = "X";
    scanner = new Scanner(source);
    assertNextToken(new Token("name", "X"));

    source = "X -> F";
    scanner = new Scanner(source);
    assertNextToken(new Token("name", "X"));
    assertNextToken(new Token("operator", "->"));
    assertNextToken(new Token("name", "F"));
  }

  public function testEOL():void {
    scanner = new Scanner("X");
    assertNextToken(new Token("name", "X"));
    assertNextToken(new Token("eof", null));

    scanner = new Scanner("X;");
    assertNextToken(new Token("name", "X"));
    assertNextToken(new Token("eol", null));
    assertNextToken(new Token("eof", null));

    scanner = new Scanner("X;\nF;");
    assertNextToken(new Token("name", "X"));
    assertNextToken(new Token("eol", null));
    assertNextToken(new Token("name", "F"));
    assertNextToken(new Token("eol", null));
    assertNextToken(new Token("eof", null));
  }

  private function assertNextToken(expected:Token):void {
    var next:Token = scanner.nextToken();
    assertNotNull(next);
    assertEquals(expected.type, next.type);
    assertEquals(expected.value, next.value);
  }
}
}