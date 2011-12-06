package lsystem.parser {

public class RulesParser {
  private var currentToken:Token;
  private var _rulesScanner:Scanner;

  public function RulesParser(scanner:Scanner) {
    _rulesScanner = scanner;
  }

  public function rules():Array {
    var rules:Array = new Array();
    currentToken = _rulesScanner.nextToken();
    while (currentToken.type != Token.EOF) {
      rules.push(parseRule());
      currentToken = _rulesScanner.nextToken();
    }

    if (currentToken.type == Token.EOF) {
      return rules;
    }
    else {
      throw new Error("Unexpected token");
    }
  }

  public function axioms():Array {
    var axioms:Array = new Array();
    currentToken = _rulesScanner.nextToken();
    return parseCommands(true);
  }

  private function parseRule():Rule {
    var variable:Command;
    var commands:Array;
    variable = parseVariable();
    commands = parseCommands();
    return new Rule(variable, commands);
  }

  private function parseVariable():Command {
    var result:String = "";
    while (currentToken.type == Token.NAME || currentToken.value == "F") {
      result += currentToken.value;
      currentToken = _rulesScanner.nextToken();
    }
    if (currentToken.type == Token.EQUALS) {
      currentToken = _rulesScanner.nextToken();
    }
    return new Command("Var", result);
  }

  private function parseCommands(fIsVar:Boolean = false):Array {
    var result:Array = [];
    while (currentToken.type != Token.EOL && currentToken.type != Token.EOF) {
      result.push(parseCommand(fIsVar));
      currentToken = _rulesScanner.nextToken();
    }
    return result;
  }

  private function parseCommand2(cmdToken:Token, fIsVar:Boolean):Command {
    switch (cmdToken.value) {
      case 'F':
        if (fIsVar) {
          return new Command("Var", cmdToken.value)
        } else {
          return new Command("Forward");
        }
      case 'J':
        return new Command("Jump");
      case '+':
        return new Command("TurnRight");
      case '-':
        return new Command("TurnLeft");
      case '!':
        return new Command("Reverse"); //reverse the meaning of + and -
      case '|':
        return new Command("TurnRound");
      case '[':
        return new Command("Save");
      case ']':
        return new Command("Restore");
      case '@':
        var numberToken:Token = _rulesScanner.nextToken();
        if (numberToken.type !== Token.NUMBER) {
          throw new Error("Number expected")
        }
        return new Command("ScaleLength", Number(numberToken.value));
      default:
        return new Command("Var", cmdToken.value);
    }
  }

  private function parseCommand(fIsVar:Boolean):Command {
    var cmd:Command;
    if (currentToken.type == Token.OPERATOR || currentToken.type == Token.NAME) {
      cmd = parseCommand2(currentToken, fIsVar);
    }
    return cmd;
  }
}
}



