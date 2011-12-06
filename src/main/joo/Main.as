package {
import flash.display.Sprite;
import flash.text.TextField;

import lsystem.LSystem;
import lsystem.LSystemConfig;
import lsystem.parser.RulesParser;
import lsystem.parser.Scanner;
import lsystem.rendering.Renderer;

[SWF( backgroundColor='0xFFFFFF', frameRate='30', width='640', height='480')]
public class Main extends Sprite {

  //0-10
  private var lsystems:Array = [
    {
      name:  "Lsystema vulgaris",
      productions: "F -> F[+F]F[-F]F",
      axiom: "F",
      order: 5,
      angle: 27.7,

      startAngle:-90.0,
      lineLength: 3.0,
      lineThickness: 1
    },
    {
      name:  "Tree 1",
      productions: "x -> F-[[x]+x]+F[+Fx]-x;" +
              "F -> FF",
      axiom: "x",
      order: 6,
      angle: 27.0,

      startAngle:-90.0,
      lineLength: 3.0,
      lineThickness: 1
    },
    {
      name:  "Tree 2",
      productions: "t -> r-[t]++[++l]r[--l]+[t]--t;" +
              "r -> F[++l][--l]F;" +
              "l -> [+Fx-Fx-Fx+|+Fx-Fx-Fx|+FxFx];" +
              "Fx -> Fx;" +
              "F -> FF",
      axiom: "t",
      order: 6,
      angle: 37.0,

      startAngle:-90.0,
      lineLength: 4.0,
      lineThickness: 1
    },
    {
      name:  "Tree 3",
      productions: "F -> FF-[-F+F+F]+[+F-F-F];" +
              "F -> FF-[-F+F][FF]+[+F-F];" +
              "x -> yyyyF",
      axiom: "x",
      order: 5,
      angle: 22.0,

      startAngle:-90.0,
      lineLength: 6.0,
      lineThickness: 1
    },
    {
      name:  "Koch curve",
      productions: "F -> F-F++F-F",
      axiom: "F",
      order: 4,
      angle: 60.0,

      startAngle:-90.0,
      lineLength: 4.0,
      lineThickness: 2
    },
    {
      name:  "Quad Koch curve",
      productions: "F -> F+F-F-FF+F+F-F",
      axiom: "F+F+F+F",
      order: 3,
      angle: 90.0,

      startAngle:-90.0,
      lineLength: 5.0,
      lineThickness: 1
    },
    {
      name:  "Hilbert curve",
      productions: "F -> F;" +
              "x -> -yF+xFx+Fy-;" +
              "y -> +xF-yFy-Fx+;",
      axiom: "x",
      order: 6,
      angle: 90.0,

      startAngle:-90.0,
      lineLength: 5.0,
      lineThickness: 1
    },
    {
      name:  "Sierpinski Arrowhead",
      productions: "F -> F;" +
              "x -> yF+xF+y;" +
              "y -> xF-yF-x",
      axiom: "yF",
      order: 6,
      angle: 60.0,

      startAngle:-90.0,
      lineLength: 5.0,
      lineThickness: 1
    },
    {
      name:  "Dragon curve",
      productions: "F -> F;" +
              "x -> x+yF+;" +
              "y -> -Fx-y",
      axiom: "x",
      order: 10,
      angle: 90.0,

      startAngle:-90.0,
      lineLength: 5.0,
      lineThickness: 1
    },
    {
      name:  "Lévy C curve",
      productions: "F -> +F--F+",
      axiom: "F",
      order: 12,
      angle: 45.0,

      startAngle:-90.0,
      lineLength: 5.0,
      lineThickness: 1
    },
    {
      name:  "Penrose Tiling P3",
      productions: "w -> yF++zF----xF[-yF----wF]++;" +
              "x -> +yF--zF[---wF--xF]+;" +
              "y -> -wF++xF[+++yF++zF]-;" +
              "z -> --yF++++wF[+zF++++xF]--xF;" +
              "F -> F",
      axiom: "[x]++[x]++[x]++[x]++[x]",
      order: 6,
      angle: 36.0,

      startAngle:-90.0,
      lineLength: 6.0,
      lineThickness: 1
    },
    {
      name: "Plant-like structure",
      productions: "x -> F[+x]F[-x]+x;F -> FF",
      axiom: "x" ,
      order: 6,
      angle: 18.0,
      startAngle:-90.0,
      lineLength: 3.0,
      lineThickness: 1
    },
    {
      name: "Lace",
      productions: "w -> +++x--F--zFx+;" +
              "x -> ---w++F++yFw-;" +
              "y -> +zFx--F--z+++;" +
              "z -> -yFw++F++y---",
      axiom: "w" ,
      order: 8,
      angle: 30.0,
      startAngle:-90.0,
      lineLength: 6.0,
      lineThickness: 1
    },
    {
      name: "weed",
      productions: "F -> FF-[xy]+[xy];x -> +Fy;" +
              "y -> -Fx",
      axiom: "F" ,
      order: 6,
      angle: 22.5,
      startAngle:-90.0,
      lineLength: 3.0,
      lineThickness: 1
    }   ,
    {
      name: "Algea",
      productions: "a -> FFFFFv[+++h][---q]Fb;" +
              "b -> FFFFFv[+++h][---q]Fc;" +
              "c -> FFFFFv[+++fa]fd;" +
              "d -> FFFFFv[+++h][---q]fe;" +
              "e -> FFFFFv[+++h][---q]fg;" +
              "g -> FFFFFv[---fa]fa;" +
              "h -> iFFF;" +
              "i -> FFFF[--m]j;" +
              "j -> FFFF[--n]k;" +
              "k -> FFFF[--o]l;" +
              "l -> FFFF[--p];" +
              "m -> FFn;" +
              "n -> FFo;" +
              "o -> FFp;" +
              "p -> FF;" +
              "q -> rFF;" +
              "r -> FFFF[++m]s;" +
              "s -> FFFF[++n]t;" +
              "t -> FFFF[++o]u;" +
              "u -> FFFF[++p];" +
              "v -> Fv",
      axiom: "aF" ,
      order: 7,
      angle: 12.0,
      startAngle:-90.0,
      lineLength: 7.0,
      lineThickness: 1
    },
    {
      name: "Big H",
      productions: "h -> @0.65 F [+h] [-h];",
      axiom: "[h]--h" ,
      order: 15,
      angle: 80.0,
      startAngle:-90.0,
      lineLength: 480.0,
      lineThickness: 1
    },
    {
      name: "Big H2",
      productions: "h -> @0.65 F [+h] [-h];",
      axiom: "[h]" ,
      order: 15,
      angle: 80.0,
      startAngle:-90.0,
      lineLength: 480.0,
      lineThickness: 1
    },
    {
      name: "Weed 2",
      productions: "x -> F[@0.5+++++++++x]-F[@0.4-----------!x]@0.6x",
      axiom: "+++++++++++++x",
      order: 7,
      angle: 50.0,
      startAngle:-90.0,
      lineLength: 480.0,
      lineThickness: 1
    }
  ];

  private function queryParams():Object {
    var qsParm:Object = {};
    var query = window.location.search.substring(1);
    var parms = query.split('&');
    for (var i = 0; i < parms.length; i++) {
      var pos = parms[i].indexOf('=');
      if (pos > 0) {
        var key = parms[i].substring(0, pos);
        var val = parms[i].substring(pos + 1);
        qsParm[key] = val;
      }
    }
    return qsParm;
  }

  public function Main() {
    var lsystemConfig:LSystemConfig;
    var index:Number = queryParams()['lsystem'];
    lsystemConfig = LSystemConfig(lsystems[index]);

    if (!lsystemConfig) {
      throw new Error("no config provided!");
    }
    var rulesParser:RulesParser = new RulesParser(new Scanner(lsystemConfig.productions));
    trace(lsystemConfig.productions);
    var rules:Array = rulesParser.rules();
    for (var i:int = 0; i < rules.length; i++) {
      trace(rules[i]);
    }
    var axiomParser:RulesParser = new RulesParser(new Scanner(lsystemConfig.axiom));
    var axioms:Array = axiomParser.axioms();
    for (var j:int = 0; j < axioms.length; j++) {
      trace(axioms[j]);
    }

    var name:TextField = new TextField();
    name.text = lsystemConfig.name;
    addChild(name);
    var lSystem:LSystem = new LSystem(axioms, rules, lsystemConfig.angle, lsystemConfig.order);
    var renderer:Renderer = new Renderer(lSystem, lsystemConfig.lineLength)
    addChild(renderer);
    renderer.render(320, 480, lsystemConfig.startAngle, lsystemConfig.lineThickness, -1);

  }
}
}