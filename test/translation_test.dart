import 'package:flocalizer/models/translation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should get the proper value', () {
    final testKey = "testKey";
    final testValue = "testValue";
    final translation = Translation.withMap({testKey: testValue});
    final value = translation.getByKey(testKey);
    expect(value, testValue);
  });

  test('should get back the key for not existing key', () {
    final testKey = "testKey";
    final translation = Translation.withMap({});
    expect(translation.getByKey(testKey), testKey);
  });

  test('should throw', () {
    expect(()=>Translation.withMap(null), throwsException);
  });
  test('should throw for invalid translation map', () {
    final translationMap = {"key": null};
    expect(()=>Translation.withMap(translationMap), throwsException);
  });
}
