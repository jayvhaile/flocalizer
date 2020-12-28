import 'package:flocalizer/parsers/parser.dart';
typedef OperatorFunc = String Function(
    String, Map<String, dynamic>, ParserFunc);

abstract class Operator {
  String operate(
      String value,
      [Map<String, dynamic> arguments,
        ParserFunc recurse]
      );
}