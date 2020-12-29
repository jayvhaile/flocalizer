import 'package:flocalizer/flutter/flocalization_provider_widget.dart';
import 'package:flocalizer/loaders/simple_flocales_loader.dart';
import 'package:flocalizer/main/flocalization.dart';
import 'package:flocalizer/main/flocalization_provider.dart';
import 'package:flocalizer/models/locale.dart';
import 'package:flocalizer/models/translation.dart';
import 'package:flocalizer/parsers/operators_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final fLocales = [
    FLocale(
      languageCode: 'en',
      countryCode: 'us',
      translation: Translation.withMap({'greetings': 'Hello'}),
    ),
    FLocale(
      languageCode: 'am',
      countryCode: 'et',
      translation: Translation.withMap({'greetings': 'ሰላም'}),
    ),
  ];
  final provider = FlocalizationProvider.init(
    fLocalesLoader: SimpleFlocalesLoader(fLocales),
    parser: OperatorsParser.def(),
    defaultActiveLocaleId: 'en_us',
    defaultLocales: fLocales,
  );
  final flocalization = provider.getActiveFlocalization();

  final widget = FlocalizationProviderWidget(
    provider: provider,
    builder: (context) => MaterialApp(home: Text('greetings'.tr())),
  );
  group('Flocalization Widget Tests', () {
    testWidgets(
      'should find translated text widget',
      (WidgetTester tester) async {
        await tester.pumpWidget(widget);
        expect(find.text(flocalization.tr('greetings')), findsOneWidget);
      },
    );
    testWidgets('should find none widget', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      expect(find.text(flocalization.tr('greetins')), findsNothing);
    });
    testWidgets('should update localization when changed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        StreamBuilder<Flocalization>(
          initialData: flocalization,
          stream: provider.flocalizationStream,
          builder: (context, snapshot) {
            return FlocalizationProviderWidget(
              provider:provider,
              builder: (context) => MaterialApp(
                home: Text('greetings'.tr()),
              ),
            );
          },
        ),
      );
      expect(find.text(provider.tr('greetings')), findsOneWidget);
      provider.setActiveLocaleId('am_et');
      await tester.pump();
      expect(find.text(provider.tr('greetings')), findsOneWidget);
      provider.close();
    });
  });
}
