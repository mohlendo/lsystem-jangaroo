package lsystem {
import flash.display.Shape;
import flash.events.Event;
import flash.geom.Point;

import lsystem.parser.Command;
import lsystem.parser.Rule;
import lsystem.rendering.Turtle;

public class LSystem extends Shape {
  private var turtle:Turtle;
  private var _axiom:Array;
  private var _rules:Array;

  private var _angle:Number;
  private var _order:Number;
  private var _distance:Number;

  private var _commands:Array = [];
  private var _fProductions:Array = [];

  public function LSystem(axiom:Array, rules:Array, angle:Number, order:Number, distance:Number) {
    _axiom = axiom;
    _rules = rules;
    _angle = angle;
    _order = order;
    _distance = distance;
    for each (var r:Rule in rules) {
      if (r.variable.value == "F") {
        _fProductions.push(r.commands);
      }
    }
    grow(axiom, order);
  }

  public function get axiom():Array {
    return _axiom;
  }

  public function get rules():Array {
    return _rules;
  }

  public function get angle():Number {
    return _angle;
  }

  public function render(x:Number, y:Number, startAngle:Number, lineThickness:Number, iterationSteps:Number = -1):void {
    turtle = new Turtle(new Point(x, y), degToRad(startAngle), 0x659D32, lineThickness, graphics);

    addEventListener(Event.ENTER_FRAME, handleFrameEvent);
  }

  private function handleFrameEvent(event:Event):void {
    trace("handle frame event");
    if (!iteratePath()) {
      trace("stop drawing");
      removeEventListener(Event.ENTER_FRAME, handleFrameEvent);
    }
  }

  private function iteratePath():Boolean {
    for (var i:uint = 0; i < _commands.length; i++) {
      var code:int = _commands[i];

      switch (code) {
        case 0://"Forward":
          turtle.forward(_distance, true);
          break;
        case 1://"TurnRight":
          turtle.turn(degToRad(angle));
          break;
        case 2://"TurnLeft":
          turtle.turn(-degToRad(angle));
          break;
        case 3://"TurnRound":
          turtle.turn(degToRad(180.0));
          break;
        case 4://"Save":
          turtle.saveTurtle();
          break;
        case 5://"Restore":
          turtle.restoreTurtle();
          break;
        case 6://ScaleLength
          _distance = _distance * _commands[i++];
          break;
      }
    }
    return false;
  }

  private function grow(commands:Array, order:uint):void {
    for (var i:uint = 0; i < commands.length; i++) {
      var cmd:Command = commands[i];
      switch (cmd.command) {
        case "Var":
          if (order > 0) {
            for (var r:int = 0; r < rules.length; r++) {
              var rule:Rule = rules[r];
              if (rule.variable.value == cmd.value) {
                grow(rule.commands, order - 1);
              }
            }
          }
          break;
        case "Forward":
          if (order > 0) {
            var randomNo:uint = uint(Math.random() * (_fProductions.length));
            var fCommands:Array = _fProductions[randomNo];
            if (fCommands) {
              grow(fCommands, order - 1);
            }
          } else {
            _commands.push(0);
          }
          break;
        case "TurnRight":
          _commands.push(1);
          break;
        case "TurnLeft":
          _commands.push(2);
          break;
        case "TurnRound":
          _commands.push(3);
          break;
        case "Save":
          _commands.push(4);
          break;
        case "Restore":
          _commands.push(5);
          break;
        case "ScaleLength":
          _commands.push(6);
          _commands.push(Number(cmd.value));
          break;
      }
    }
  }

  private function getLineAngleRad(deltaX:Number, deltaY:Number):Number {
    return Math.atan2(deltaY, deltaX);
  }

  private function getDistBetPts(pt1:Point, pt2:Point):Number {
    return Point.distance(pt1, pt2);
  }

  private function degToRad(deg:Number):Number {
    return 2.0 * Math.PI / 360.0 * deg;
  }
}
}