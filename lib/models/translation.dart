class InvalidTranslationException implements Exception {}
class InvalidTranslationValueException implements Exception {}

class Translation {
  final Map<String, String> translationMap;

  Translation._({this.translationMap});

  factory Translation.withMap(Map<String, String> translationMap) {
    if(translationMap==null) throw InvalidTranslationException();
    if (translationMap.values.any((value) => value == null))
      throw new InvalidTranslationValueException();
    return Translation._(translationMap: translationMap);
  }

  factory Translation.empty() {
    return Translation._(translationMap: {});
  }

  String getByKey(String key) {
    return translationMap[key] ?? key;
  }
}
