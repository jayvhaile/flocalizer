typedef ParserFunc = String Function(String, Map<String, dynamic>);

abstract class Parser {
  String parse(String value, [Map<String, dynamic> arguments = const {}]);
}

