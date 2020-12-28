import 'dart:async';
import 'package:flocalizer/loaders/flocales_loader.dart';
import 'package:flocalizer/main/flocalization.dart';
import 'package:flocalizer/models/locale.dart';
import 'package:flocalizer/parsers/parser.dart';

class FlocalizationProvider {
  final FLocalesLoader fLocalesLoader;
  final Parser parser;

  final StreamController<Flocalization> _activeFlocalizationStreamController =
      StreamController();

  StreamSubscription<List<FLocale>> _loaderSubscription;
  String _activeLocaleId;
  List<FLocale> _locales;

  FlocalizationProvider.init({
    this.fLocalesLoader,
    this.parser,
    List<FLocale> defaultLocales = const [],
    String defaultActiveLocaleId,
  }) {
    this._locales = defaultLocales;
    this._activeLocaleId = defaultActiveLocaleId;
    _activeFlocalizationStreamController.sink.add(getActiveFlocalization());
    _loaderSubscription = fLocalesLoader.load().listen(setLocales);
  }

  setLocales(List<FLocale> defaultLocales) {
    this._locales = _locales;
    _activeFlocalizationStreamController.sink.add(getActiveFlocalization());
  }

  setActiveLocaleId(String id) {
    this._activeLocaleId = id;
    _activeFlocalizationStreamController.sink.add(getActiveFlocalization());
  }

  Stream<Flocalization> get flocalizationStream {
    return this._activeFlocalizationStreamController.stream;
  }

  Flocalization getActiveFlocalization() {
    return Flocalization(
      locale: _locales.firstWhere(
        (element) => element.id == _activeLocaleId,
        orElse: () => FLocale.empty(),
      ),
      parser: parser,
    );
  }

  tr(String key, [Map<String, dynamic> arg]) {
    return getActiveFlocalization().tr(key, arg);
  }

  close() {
    _loaderSubscription.cancel();
    _activeFlocalizationStreamController.close();
  }
}
