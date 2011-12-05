package lsystem.parser {

public class Rule {
  private var _variable:Command;
  private var _commands:Array;

  public function Rule(variable:Command, commands:Array) {
    this._variable = variable;
    this._commands = commands;
  }

  public function get variable():Command {
    return _variable;
  }

  public function get commands():Array {
    return _commands;
  }

  public function toString():String {
    var s:String = _variable + " -> ";
    for (var i:int = 0; i<commands.length;i++) {
      var command:Command = commands[i];
      s += command.command + "(" + (command.value ? command.value : "") + ") ";
    }
    return s;
  }
}
}