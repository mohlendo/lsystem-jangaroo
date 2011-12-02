package
{
  import flash.display.Sprite;
  import flash.events.Event;

  import lsystem.LSystem;
  import lsystem.parser.Rule;
  import lsystem.parser.RulesParser;
  import lsystem.parser.Scanner;

  [SWF( backgroundColor='0xFFFFFF', frameRate='30', width='640', height='480')]
  public class Main extends Sprite
  {

    public function Main() {
      var rulesParser:RulesParser = new RulesParser(new Scanner("X -> F-[[X]+X]+F[+FX]-X\n F -> FF"));
      var rules:Array = rulesParser.parse();
      for each (var r:Rule in rules) {
        trace(r.variable + " " + r.expression);
      }
      var lSystem:LSystem = new LSystem("X", rules, 27.0, 5, 4.0);
      addChild(lSystem);
      lSystem.draw(150, 480, -90.0, 1.0, -1);

    }
  }
}