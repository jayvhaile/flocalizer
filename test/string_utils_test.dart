import 'package:flocalizer/utils/string_utils.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("capitalize test", () {
    test('should return null', () {
      expect(StringUtils.capitalize(null), null);
    });
    test('should return empty', () {
      expect(StringUtils.capitalize(''), '');
    });
    test('should capitalize one letter', () {
      expect(StringUtils.capitalize('a'), 'A');
    });
    test('should capitalize words', () {
      expect(StringUtils.capitalize('apple'), 'Apple');
    });
    test('should have no effect', () {
      expect(StringUtils.capitalize('5apple'), '5apple');
      expect(StringUtils.capitalize(' apple'), ' apple');
    });
  });
}
