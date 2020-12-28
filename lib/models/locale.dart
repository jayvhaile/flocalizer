import 'package:flocalizer/models/translation.dart';
import 'package:flutter/material.dart';

class FLocale {
  final String languageCode;
  final String countryCode;
  final Translation translation;

  FLocale({
    @required this.languageCode,
    @required this.countryCode,
    @required this.translation,
  });

  String get id {
    return "${languageCode}_$countryCode";
  }

  factory FLocale.empty() {
    return FLocale(
      languageCode: null,
      countryCode: null,
      translation: Translation.withMap({}),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLocale &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          translation == other.translation;

  @override
  int get hashCode => id.hashCode ^ translation.hashCode;
}
