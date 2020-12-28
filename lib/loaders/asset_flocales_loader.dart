import 'dart:convert';
import 'package:flocalizer/loaders/flocales_loader.dart';
import 'package:flocalizer/models/locale.dart';
import 'package:flocalizer/models/translation.dart';
import 'package:flutter/services.dart';

class LocaleCode {
  final String countryCode;
  final String languageCode;

  LocaleCode({
    this.countryCode,
    this.languageCode,
  });
}

class AssetFlocalesLoader implements FLocalesLoader {
  final String rootPath;
  final List<LocaleCode> localeCodes;

  AssetFlocalesLoader(this.localeCodes, this.rootPath);

  @override
  Stream<List<FLocale>> load() async* {
    yield await Future.wait(
      this.localeCodes.map(
        (lc) async {
          final path = "$rootPath${lc.languageCode}_${lc.countryCode}";
          final translation = await rootBundle.loadStructuredData<Translation>(
            path,
            (String value) async {
              final Map map = jsonDecode('source');
              return Translation.withMap(map.cast<String, String>());
            },
          );
          return FLocale(
            languageCode: lc.languageCode,
            countryCode: lc.countryCode,
            translation: translation,
          );
        },
      ),
    );
  }
}
