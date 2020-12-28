import 'operator.dart';
import 'package:flocalizer/parsers/parser.dart';

class SimpleOperator implements Operator {
  final OperatorFunc operator;

  SimpleOperator(this.operator);

  @override
  String operate(String value,
      [Map<String, dynamic> arguments, ParserFunc recurse]) {
    return operator(value, arguments, recurse);
  }
}
