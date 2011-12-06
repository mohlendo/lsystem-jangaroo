package lsystem {

import lsystem.parser.Command;
import lsystem.parser.Rule;

public class LSystem {

  private var _axiom:Array;
  private var _rules:Array;

  private var _angle:Number;
  private var _order:Number;

  private var _commands:Array = [];
  private var _fProductions:Array = [];

  public function LSystem(axiom:Array, rules:Array, angle:Number, order:Number) {
    _axiom = axiom;
    _rules = rules;
    _angle = angle;
    _order = order;
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

  public function get commands():Array {
    return _commands;
  }

  public function get order():Number {
    return _order;
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
          if (order > 0 && _fProductions.length > 0) {
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
        case "Reverse":
          _commands.push(7);
          break;
      }
    }
  }
}
}