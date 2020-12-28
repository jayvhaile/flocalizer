import 'package:flocalizer/parsers/parser.dart';

class DummyParser implements Parser {
  @override
  parse(String val, [Map<String, dynamic> arguments = const {}]) {
    return val;
  }
}
