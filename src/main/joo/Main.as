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
    private var lSystem:LSystem;

    public function Main()
    {
      var rulesParser:RulesParser = new RulesParser(new Scanner("X -> F-[[X]+X]+F[+FX]-X\n" + "F -> FF"));
      var rules:Array = rulesParser.parse();
      for each (var r:Rule in rules)
      {
        trace(r.variable + " " + r.expression);
      }
      lSystem = new LSystem("X", rules, 27, 6);
      lSystem.draw(150, 300, -90, 2, 5, -1);

      //this.addEventListener(Event.ENTER_FRAME, iterate);
    }

    private function iterate(e:Event):void
    {
      lSystem.draw(150, 300, -90, 2, 5, -1);

    }
  }
}