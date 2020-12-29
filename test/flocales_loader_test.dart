import 'dart:async';

import 'package:flocalizer/flocalizer.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLoader implements FLocalesLoader {
  final Stream<List<FLocale>> stream;

  MockLoader({
    this.stream,
  });

  @override
  Stream<List<FLocale>> load() async* {
    yield* stream;
  }
}

main() {
  group(
    "loader tests",
    () {
      final sc = StreamController<List<FLocale>>();
      FlocalizationProvider.init(
        fLocalesLoader: MockLoader(stream: sc.stream),
        parser: OperatorsParser.def(),
        defaultActiveLocaleId: 'en_us',
      );
      final instance = FlocalizationProvider.getInstance();

      test('description', () async {
        sc.add(
          [
            FLocale(
              languageCode: 'en',
              countryCode: 'us',
              translation: Translation.withMap({
                'test': 'val',
              }),
            ),
          ],
        );
        await Future.delayed(Duration(seconds: 1));
        expect(instance.tr('test'), 'val');
      });
    },
  );
}
