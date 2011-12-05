package lsystem.parser {
import flexunit.framework.TestCase;

public class ScannerTest extends TestCase {
  private var scanner:Scanner;

  public function testNextToken():void {
    var source:String = "x";
    scanner = new Scanner(source);
    assertNextToken(new Token(Token.NAME, "x"));

    source = "x -> F";
    scanner = new Scanner(source);
    assertNextToken(new Token(Token.NAME, "x"));
    assertNextToken(new Token(Token.EQUALS, "->"));
    assertNextToken(new Token(Token.OPERATOR, "F"));
  }

  public function testVariables():void {
    var source:String = "xF";
    scanner = new Scanner(source);
    assertNextToken(new Token(Token.NAME, "x"));
    assertNextToken(new Token(Token.OPERATOR, "F"));
  }

  public function testEOL():void {
    scanner = new Scanner("x");
    assertNextToken(new Token(Token.NAME, "x"));
    assertNextToken(new Token(Token.EOF, null));

    scanner = new Scanner("x;");
    assertNextToken(new Token(Token.NAME, "x"));
    assertNextToken(new Token(Token.EOL, null));
    assertNextToken(new Token(Token.EOF, null));

    scanner = new Scanner("x;\nF;");
    assertNextToken(new Token(Token.NAME, "x"));
    assertNextToken(new Token(Token.EOL, null));
    assertNextToken(new Token(Token.OPERATOR, "F"));
    assertNextToken(new Token(Token.EOL, null));
    assertNextToken(new Token(Token.EOF, null));
  }

  public function testOperators():void {
    scanner = new Scanner("-> + - @0.5 17+");
    assertNextToken(new Token(Token.EQUALS, "->"));
    assertNextToken(new Token(Token.OPERATOR, "+"));
    assertNextToken(new Token(Token.OPERATOR, "-"));
    assertNextToken(new Token(Token.OPERATOR, "@"));
    assertNextToken(new Token(Token.NUMBER, "0.5"));
    assertNextToken(new Token(Token.NUMBER, "17"));
    assertNextToken(new Token(Token.OPERATOR, "+"));
    assertNextToken(new Token(Token.EOF, null));
  }

  private function assertNextToken(expected:Token):void {
    var next:Token = scanner.nextToken();
    assertNotNull(next);
    assertEquals(expected.type, next.type);
    assertEquals(expected.value, next.value);
  }
}
}