package lsystem.parser {
public class Command {
  private var _command:String;
  private var _value:*;

  public function Command(command:String, value:* = null) {
    this._command = command;
    this._value = value;
  }


  public function get command():String {
    return _command;
  }

  public function get value():* {
    return _value;
  }


  public function toString():String {
    return command + "(" + (value ? value : "") + ") ";
  }
}
}