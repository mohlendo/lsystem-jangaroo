package lsystem.parser
{

  public class Token
  {
    public static const EOF:String = "eof";
    public static const EOL:String = "eol";
    public static const OPERATOR:String = "operator";
    public static const NAME:String = "name";
    public static const NUMBER:String = "number";
    public static const EQUALS:String = "eq";

    public var value:String;
    public var type:String;

    public function Token(type:String, value:String)
    {
      this.type = type;
      this.value = value;
    }
  }
}

