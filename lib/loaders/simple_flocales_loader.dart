import 'package:flocalizer/loaders/flocales_loader.dart';
import 'package:flocalizer/models/locale.dart';

class SimpleFlocalesLoader implements FLocalesLoader {
  final List<FLocale> fLocales;

  SimpleFlocalesLoader(this.fLocales);

  @override
  Stream<List<FLocale>> load() async* {
    yield this.fLocales;
  }
}
