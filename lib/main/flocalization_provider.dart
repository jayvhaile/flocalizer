import 'dart:async';
import 'package:flocalizer/loaders/flocales_loader.dart';
import 'package:flocalizer/main/flocalization.dart';
import 'package:flocalizer/models/locale.dart';
import 'package:flocalizer/parsers/parser.dart';

extension localization_ext on String {
  tr([Map<String, dynamic> arg]) {
    return FlocalizationProvider.getInstance().tr(this, arg);
  }

  get trg {
    return FlocalizationProvider.getInstance().tr(this);
  }
}

class FlocalizationProvider {
  static FlocalizationProvider _instance;

  static FlocalizationProvider getInstance() {
    if (_instance == null) throw "Instance not initialized yet";
    return _instance;
  }

  static FlocalizationProvider init({
    FLocalesLoader fLocalesLoader,
    Parser parser,
    List<FLocale> defaultLocales = const [],
    String defaultActiveLocaleId,
  }) {
    if (_instance != null) throw "Instance already initialized!";
    _instance = FlocalizationProvider._(
      fLocalesLoader: fLocalesLoader,
      parser: parser,
      defaultLocales: defaultLocales,
      defaultActiveLocaleId: defaultActiveLocaleId,
    );
    return _instance;
  }

  final FLocalesLoader fLocalesLoader;
  final Parser parser;

  final StreamController<Flocalization> _activeFlocalizationStreamController =
      StreamController();

  StreamSubscription<List<FLocale>> _loaderSubscription;
  String _activeLocaleId;
  List<FLocale> _locales;
  Stream<Flocalization> _stream;

  FlocalizationProvider._({
    this.fLocalesLoader,
    this.parser,
    List<FLocale> defaultLocales,
    String defaultActiveLocaleId,
  }) {
    this._locales = defaultLocales;
    this._activeLocaleId = defaultActiveLocaleId;
    _activeFlocalizationStreamController.sink.add(getActiveFlocalization());
    _loaderSubscription = fLocalesLoader.load().listen(setLocales);
    this._stream =
        this._activeFlocalizationStreamController.stream.asBroadcastStream();
  }

  setLocales(List<FLocale> locales) {
    print("SET LOCALES $locales");
    this._locales = locales;
    _activeFlocalizationStreamController.sink.add(getActiveFlocalization());
  }

  setActiveLocaleId(String id) {
    this._activeLocaleId = id;
    _activeFlocalizationStreamController.sink.add(getActiveFlocalization());
  }

  Stream<Flocalization> get flocalizationStream {
    return this._stream;
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
