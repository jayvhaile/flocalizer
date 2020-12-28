import 'package:flocalizer/models/locale.dart';
import 'package:flocalizer/parsers/parser.dart';

class Flocalization {
  final FLocale locale;
  final Parser _parser;

  Flocalization({
    this.locale,
    Parser parser,
  }) : _parser = parser;

  tr(String key, [Map<String, dynamic> argument]) {
    final translation = locale.translation;
    final value = translation.getByKey(key);
    return _parser.parse(value, {
      ...?argument,
      'translation': translation,
    });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Flocalization &&
          runtimeType == other.runtimeType &&
          locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}
