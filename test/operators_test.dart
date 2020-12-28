import 'package:flocalizer/models/translation.dart';
import 'package:flocalizer/operations/interpolator.dart';
import 'package:flocalizer/operations/named_operator.dart';
import 'package:flocalizer/operations/pluralizer.dart';
import 'package:flocalizer/operations/reference_operator.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Operation Tests', () {
    group("Interpolate Operation Test", () {
      final interpolateOperation = Interpolator();
      test('should return own', () {
        final result = interpolateOperation.operate('value', {});
        expect(result, 'value');
      });

      test('should return with own when empty', () {
        final result = interpolateOperation.operate('value {}', {});
        expect(result, 'value {}');
      });

      test('should replace with self if key not found', () {
        final result = interpolateOperation.operate('value {apple}', {});
        expect(result, 'value {apple}');
      });

      test('should replace with value if value is found', () {
        final result =
            interpolateOperation.operate('value {apple}', {'apple': 5});
        expect(result, 'value 5');
      });

      test('should replace multiple values', () {
        final result = interpolateOperation.operate(
          'value {apple} {ball}',
          {'apple': 5, 'ball': 10},
        );
        expect(result, 'value 5 10');
      });
    });

    group('Pluralize Tests', () {
      final pluralizeOperation = Pluralizer();

      test("should return own when no plural is found", () {
        final value = "apple";
        expect(pluralizeOperation.operate(value), value);
      });
      test("should return first when on invalid", () {
        final value = "apple | ";
        expect(pluralizeOperation.operate(value), 'apple');
      });

      test("should return first", () {
        final value = "apple | apples";
        expect(pluralizeOperation.operate(value), 'apple');
      });
      test("should return first with 1", () {
        final value = "apple | apples";
        expect(pluralizeOperation.operate(value, {'n': 1}), 'apple');
      });

      test("should return first", () {
        final value = "zero apples | one apple | {n} apples";
        expect(pluralizeOperation.operate(value, {'n': 0}), 'zero apples');
      });
      test("should return second", () {
        final value = "zero apples | one apple | 2 apples";
        expect(pluralizeOperation.operate(value, {'n': 1}), 'one apple');
      });
      test("should return multi", () {
        final value = "zero apples | one apple | 2 apples";
        expect(pluralizeOperation.operate(value, {'n': 2}), '2 apples');
      });
      test("should return multi when exceeding", () {
        final value = "zero apples | one apple | 51 apples";
        expect(pluralizeOperation.operate(value, {'n': 51}), '51 apples');
      });
      test("should return third when negative", () {
        final value = "zero apples | one apple | -1 apples";
        expect(pluralizeOperation.operate(value, {'n': -1}), '-1 apples');
      });

      test("should return when many", () {
        final value = "zero apples | one apple | two apples | three apples";
        expect(pluralizeOperation.operate(value, {'n': 2}), 'two apples');
      });
    });

    group('Named Operation Test', () {
      final dummyOperation = NamedOperator(
        'dummy',
        (v, arg, r) => "dummy",
      );
      test('should replace with dummy', () {
        expect(
          dummyOperation.operate('hello @dummy:there'),
          'hello dummy',
        );
      });

      test('should replace multiple with dummy', () {
        expect(
          dummyOperation.operate('hello @dummy:there, you are a @dummy:dog'),
          'hello dummy, you are a dummy',
        );
      });

      test('should do nothing', () {
        expect(
            dummyOperation.operate('hello @upper:there'), 'hello @upper:there');
      });
    });

    group('Reference Operation Test', () {
      final Translation translation = Translation.withMap({'name': 'Abebe'});
      final referenceOperation = Referencer();

      test('should reference', () {
        expect(
            referenceOperation.operate(
              'hello @ref:name',
              {'translation': translation},
            ),
            'hello Abebe');
      });
      test('should reference key when not found', () {
        expect(
            referenceOperation.operate(
              'hello @ref:Abebe',
              {'translation': translation},
            ),
            'hello Abebe');
      });
    });
  });
}
