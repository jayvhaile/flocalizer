import 'package:flocalizer/loaders/simple_flocales_loader.dart';
import 'package:flocalizer/main/flocalization.dart';
import 'package:flocalizer/main/flocalization_provider.dart';
import 'package:flocalizer/models/locale.dart';
import 'package:flocalizer/models/translation.dart';
import 'package:flocalizer/parsers/operators_parser.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group(
    'flocalization',
    () {
      final flocalization = Flocalization(
        locale: FLocale(
          languageCode: 'en',
          countryCode: 'us',
          translation: Translation.withMap({'greetings': 'Hello'}),
        ),
        parser: OperatorsParser.def(),
      );

      test('should translate with the selected locale', () {
        expect(flocalization.tr('greetings'), 'Hello');
      });

      test('should translate with key when selected locale is not available',
          () {
        expect(flocalization.tr('none'), 'none');
      });
    },
  );
  group('FlocalizationProvider tests', () {
    final fLocales = [
      FLocale(
        languageCode: 'en',
        countryCode: 'us',
        translation: Translation.withMap({'greetings': 'Hello'}),
      ),
      FLocale(
        languageCode: 'am',
        countryCode: 'et',
        translation: Translation.withMap({'greetings': 'Selam'}),
      ),
    ];
    final provider = FlocalizationProvider.init(
      fLocalesLoader: SimpleFlocalesLoader(fLocales),
      parser: OperatorsParser.def(),
      defaultActiveLocaleId: 'en_us',
      defaultLocales: fLocales,
    );

    test('should change active', () {
      expect(provider.tr('greetings'), 'Hello');
      provider.setActiveLocaleId('am_et');
      expect(provider.tr('greetings'), 'Selam');
    });
  });
}
