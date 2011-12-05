package lsystem.parser {
import flexunit.framework.TestCase;

public class RulesParserTest extends TestCase {
  private var rulesParser:RulesParser;

  public function testRules():void {
    rulesParser = new RulesParser(new Scanner("x -> F;"));
    var rules:Array = rulesParser.rules();
    assertEquals(1, rules.length);
    var rule:Rule = rules[0];
    assertEquals("x", rule.variable.value);
    assertEquals("Var", rule.variable.command);
    var command:Command = rule.commands[0];
    assertEquals("Forward", command.command);
    assertNull(command.value);
  }

  public function testAxioms():void {
    rulesParser = new RulesParser(new Scanner("F"));
    var axioms:Array = rulesParser.axioms();
    assertEquals(1, axioms.length);
    var cmd:Command = axioms[0];
    assertEquals("Var", cmd.command);
    assertEquals("F", cmd.value);

    rulesParser = new RulesParser(new Scanner("xF"));
    axioms = rulesParser.axioms();
    assertEquals(2, axioms.length);
    cmd = axioms[0];
    assertEquals("Var", cmd.command);
    assertEquals("x", cmd.value);

    cmd = axioms[1];
    assertEquals("Var", cmd.command);
    assertEquals("F", cmd.value);
  }
}
}