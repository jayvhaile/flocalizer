import '../models/locale.dart';

abstract class FLocalesLoader {
  Stream<List<FLocale>> load();
}