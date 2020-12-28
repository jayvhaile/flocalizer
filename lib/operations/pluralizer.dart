import 'operator.dart';
import 'package:flocalizer/parsers/parser.dart';

class Pluralizer implements Operator {
  @override
  String operate(
      String value,
      [Map<String, dynamic> arguments,
        ParserFunc recurse]
      ) {
    if (!value.contains(' | ')) return value;
    int num = (arguments ?? {})['n'] ?? 0;
    int n = num;
    final splits = value.split(' | ');
    if (num > splits.length || num < 0) n = splits.length - 1;
    if (splits.length == 2 && num == 1) n = 0;
    final val = splits[n].trim();
    return recurse?.call(val, arguments) ?? val;
  }
}
