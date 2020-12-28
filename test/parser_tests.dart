import 'package:flocalizer/models/translation.dart';
import 'package:flocalizer/operations/interpolator.dart';
import 'package:flocalizer/operations/named_operator.dart';
import 'package:flocalizer/operations/pluralizer.dart';
import 'package:flocalizer/operations/reference_operator.dart';
import 'package:flocalizer/parsers/operators_parser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flocalizer/utils/string_utils.dart';

void main() {
  final translation = Translation.withMap({
    'apple': 'zero apple | one apple | {n} apples',
    'greetings': 'Hi {name}'
  });
  final operations = [
    Pluralizer(),
    Interpolator(),
    Referencer(),
    NamedOperator('upper', (v, arg, r) => v.toUpperCase()),
    NamedOperator('lower', (v, arg, r) => v.toLowerCase()),
    NamedOperator('cap', (v, arg, r) => v.capitalize()),
  ];

  final parser = OperatorsParser(operations);

  group("Parser Integration Tests", () {
    test("should return own", () {
      expect(parser.parse('apple'), 'apple');
    });
    test("should pluralize and interpolate", () {
      const value = 'zero {label} | one {label} | {n} {label}';
      expect(
          parser.parse(
              value, {'n': 2, 'label': 'apples', 'translation': translation}),
          '2 apples');
    });
    test("should pluralize and transform and interpolate", () {
      const value = '{n} @upper:{label} | {n} {label}';
      expect(
          parser.parse(
              value, {'n': 1, 'label': 'apples', 'translation': translation}),
          '1 APPLES');
    });
    test("should reference and pluralize", () {
      const value = "I have @ref:apple";
      expect(parser.parse(value, {'n': 5, 'translation': translation}),
          'I have 5 apples');
    });
    test("should reference and interpolate", () {
      const value = "@ref:greetings, Welcome";
      expect(parser.parse(value, {'name': 'Jv', 'translation': translation}),
          'Hi Jv, Welcome');
    });
  });
}
