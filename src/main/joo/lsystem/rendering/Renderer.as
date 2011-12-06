package lsystem.rendering {
import flash.display.Shape;
import flash.events.Event;
import flash.geom.Point;

import lsystem.LSystem;

public class Renderer extends Shape {
  private var turtle:Turtle;
  private var lsystem:LSystem;
  private var _lineLength:Number;
  private var reverse:Boolean = false;

  public function Renderer(lsystem:LSystem, lineLength:Number) {
    this.lsystem = lsystem;
    this._lineLength = lineLength;
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
    for (var i:uint = 0; i < lsystem.commands.length; i++) {
      var code:int = lsystem.commands[i];

      switch (code) {
        case 0://"Forward":
          turtle.forward(_lineLength, true);
          break;
        case 1://"TurnRight":
          if (reverse) {
            turtle.turn(-degToRad(lsystem.angle));
          } else {
            turtle.turn(degToRad(lsystem.angle));
          }
          break;
        case 2://"TurnLeft":
          if (reverse) {
            turtle.turn(degToRad(lsystem.angle));
          } else {
            turtle.turn(-degToRad(lsystem.angle));
          }
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
          i = i + 1;
          var scale:Number = lsystem.commands[i];
          _lineLength = _lineLength * scale;
          break;
        case 7://Reverse
          reverse = !reverse;
          break;
      }
    }
    return false;
  }

  private function getLineAngleRad(deltaX:Number, deltaY:Number):Number {
    return Math.atan2(deltaY, deltaX);
  }

  private function getDistBetPts(pt1:Point, pt2:Point):Number {
    return Point.distance(pt1, pt2);
  }

  private function degToRad(deg:Number):Number {
    return deg * Math.PI / 180.0;
  }
}
}