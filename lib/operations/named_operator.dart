import 'operator.dart';
import 'package:flocalizer/parsers/parser.dart';

class NamedOperator implements Operator {
  final String name;
  final OperatorFunc operator;

  NamedOperator(this.name, this.operator);

  @override
  String operate(
      String value,
      [Map<String, dynamic> arguments,
        ParserFunc recurse]
      ) {
    final reg = r'(@name:([\w.]+|\((.+)\)))'.replaceAll('name', name);
    final _regex = new RegExp(reg);
    if (!value.contains(_regex)) return value;
    return value.replaceAllMapped(_regex, (match) {
      final operatingValue =
          match.group(match.groupCount) ?? match.group(match.groupCount - 1);
      final result = operator(operatingValue, arguments, recurse);
      return result;
    });
  }
}
