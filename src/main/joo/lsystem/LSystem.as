package lsystem {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import lsystem.parser.Rule;
import lsystem.rendering.Turtle;

public class LSystem extends Shape {
  private var turtle:Turtle;
  private var _start:String;
  private var _rules:Array;

  private var _angle:Number;
  private var _order:Number;
  private var _fProductions:Array;
  private var _distance:Number;

  private var finalPath:Array = [];

  public function LSystem(start:String, rules:Array, angle:Number, order:Number, distance:Number) {
    _start = start;
    _rules = rules;
    _angle = angle;
    _order = order;
    _distance = distance;
    _fProductions = new Array();

    for each (var r:Rule in rules) {
      if (r.variable == "F") {
        _fProductions.push(r.expression);
      }
    }

    produceString(_start, _order);
    finalPath.position = 0;
  }

  public function get start():String {
    return _start;
  }

  public function get rules():Array {
    return _rules;
  }

  public function get angle():Number {
    return _angle;
  }

  public function draw(x:Number, y:Number, startAngle:Number, lineThickness:Number, iterationSteps:Number = -1):void {
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
    for (var i:uint = 0; i < finalPath.length; i++) {
      var step:int = finalPath[i];

      switch (step) {
        case 1:
          turtle.turn(degToRad(angle));
          break;
        case 2:
          turtle.turn(-degToRad(angle));
          break;
        case 3:
          turtle.turn(degToRad(180.0));
          break;
        case 4:
          turtle.forward(_distance, true);
          break;
        case 5:
          turtle.saveTurtle();
          break;
        case 6:
          turtle.restoreTurtle();
          break;

      }
    }
    return false;
  }

  private function produceString(production:String, order:uint):void {
    for (var i:uint = 0; i < production.length; i++) {
      switch (production.charAt(i)) {
        case '+':
          finalPath.push(1);
          break;
        case '-':
          finalPath.push(2);
          break;
        case '|':
          finalPath.push(3);
          break;
        case 'F':
          if (order > 0) {
            var randomNo:uint = uint(Math.random() * (_fProductions.length));
            var fStr:String = _fProductions[randomNo];
            if (fStr) {
              produceString(fStr, order - 1);
            }
          }
          else {
            finalPath.push(4);
          }
          break;
        case '[':
          finalPath.push(5);
          break;
        case ']':
          finalPath.push(6);
          break;
        default:
          if (order > 0) {
            for (var r:int =0; r < rules.length; r++) {
              var rule:Rule = rules[r];
              if (rule.variable == production.charAt(i)) {
                produceString(rule.expression, order - 1);
              }
            }
          }
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