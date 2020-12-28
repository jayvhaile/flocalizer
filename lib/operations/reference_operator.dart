import 'package:flocalizer/models/translation.dart';

import 'operator.dart';
import 'package:flocalizer/parsers/parser.dart';

class Referencer implements Operator {
  final _regex = new RegExp(r'(@ref:([\w.]+|\((.+)\)))');

  Referencer();

  @override
  String operate(
    String value, [
    Map<String, dynamic> arguments,
    ParserFunc recurse,
  ]) {
    if (!value.contains(_regex)) return value;
    final translation = arguments['translation'] ?? Translation.empty();
    final result = value.replaceAllMapped(
      _regex,
      (match) {
        final referenceKey =
            match.group(match.groupCount) ?? match.group(match.groupCount - 1);
        final referencedValue = translation.getByKey(referenceKey);
        return recurse?.call(referencedValue, arguments) ?? referencedValue;
      },
    );
    return result;
  }
}
