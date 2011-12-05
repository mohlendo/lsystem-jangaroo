package lsystem.parser {

public class Scanner {
  private var _source:String;
  private var _tokens:Array;
  private var _pos:int;

  public function Scanner(source:String) {
    _pos = 0;
    _tokens = new Array();
    _source = source;
  }

  public function nextToken():Token {
    if (_tokens.length > 0) {
      return _tokens.shift();
    }
    skipWhites();
    if (isEOF()) {
      return new Token(Token.EOF, null);
    }
    var sym:String = _source.charAt(_pos++);
    var buffer:String = "";

    if (isVariable(sym)) {
      buffer += sym;
      return new Token(Token.NAME, buffer);
    }
    else if (sym == ";") {
      return new Token(Token.EOL, null);
    }
    else if (sym == "-") {
      buffer = sym;
      var eq:Boolean = false;
      while (!isEOF()) {
        sym = _source.charAt(_pos);
        if (sym != '>') {
          break;
        } else {
          eq = true;
        }
        buffer += sym;
        _pos++;
      }
      if (eq) {
        return new Token(Token.EQUALS, buffer);
      } else {
        return new Token(Token.OPERATOR, buffer);
      }
    } else if (isNum(sym)) {
      buffer = sym;
      while (!isEOF()) {
        sym = _source.charAt(_pos);
        if (isNum(sym) || sym == ".") {
          buffer += sym;
          _pos++;
        } else {
          break;
        }
      }
      return new Token(Token.NUMBER, buffer);
    }
    else if (isCommand(sym)) {
      return new Token(Token.OPERATOR, sym);
    } else {
      throw new Error("Unknown character: " + sym);
    }
  }

  public function pushBack(token:Token):void {
    _tokens.push(token);
  }

  private function isVariable(sym:String):Boolean {
    var c:int = sym.charCodeAt(0);
    return (c >= 97) && (c <= 122);
  }

  private function isCommand(sym:String):Boolean {
    var c:int = sym.charCodeAt(0);
    return (c >= 65) && (c <= 90) || ['[', ']', '|', '+', '-', '@', '%', '>', '<'].some(function(chr:String):Boolean {
      return sym === chr;
    });
  }

  private function isNum(sym:String):Boolean {
    var charCode:int = sym.charCodeAt(0);
    return (charCode >= 48 && charCode <= 57);
  }

  private function isEOF():Boolean {
    return (_pos >= _source.length);
  }

  private function skipWhites():void {
    while (!isEOF()) {
      var charCode:int = _source.charAt(_pos++).charCodeAt(0);
      if (charCode >= 33 && charCode <= 126) {
        --_pos;
        break;
      }
    }
  }
}
}