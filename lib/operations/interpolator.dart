import 'operator.dart';
import 'package:flocalizer/parsers/parser.dart';

class Interpolator implements Operator {
  final regex = new RegExp(r'{(\w*)}');

  @override
  String operate(
      String value,
      [Map<String, dynamic> arguments,
        ParserFunc recurse]
      ) {
    final result = value.replaceAllMapped(regex, (match) {
      final interpolatedValue =
          arguments[match.group(1)] ?? '{${match.group(1)}}';
      return interpolatedValue.toString();
    });
    return result;
  }
}
