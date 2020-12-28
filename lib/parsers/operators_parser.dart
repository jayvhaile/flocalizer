import 'package:flocalizer/operations/interpolator.dart';
import 'package:flocalizer/operations/named_operator.dart';
import 'package:flocalizer/operations/operator.dart';
import 'package:flocalizer/operations/pluralizer.dart';
import 'package:flocalizer/operations/reference_operator.dart';
import 'package:flocalizer/parsers/parser.dart';
import 'package:flocalizer/utils/string_utils.dart';

class OperatorsParser implements Parser {
  final List<Operator> operators;

  OperatorsParser(this.operators);

  factory OperatorsParser.def() {
    return OperatorsParser([
      Pluralizer(),
      Interpolator(),
      Referencer(),
      NamedOperator('upper', (v, arg, r) => v.toUpperCase()),
      NamedOperator('lower', (v, arg, r) => v.toLowerCase()),
      NamedOperator('cap', (v, arg, r) => v.capitalize()),
    ]);
  }

  @override
  String parse(String value, [Map<String, dynamic> arguments = const {}]) {
    String val = value;
    for (int i = 0; i < operators.length; i++) {
      final operator = operators[i];
      val = operator.operate(val, arguments, parse);
    }
    return val;
  }
}
