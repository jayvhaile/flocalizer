import 'package:flocalizer/main/flocalization.dart';
import 'package:flutter/material.dart';

extension flocalization on BuildContext {
  String tr(String key, [Map<String, dynamic> args]) {
    return FLocalizationProviderWidget.of(this).flocalization.tr(key, args);
  }
}

class FLocalizationProviderWidget extends InheritedWidget {
  final Flocalization flocalization;
  final Widget child;

  FLocalizationProviderWidget({
    Key key,
    this.flocalization,
    this.child,
  }) : super(key: key, child: child);

  factory FLocalizationProviderWidget.of(BuildContext context) {
    FLocalizationProviderWidget widget = context
        .dependOnInheritedWidgetOfExactType<FLocalizationProviderWidget>();
    return widget;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is FLocalizationProviderWidget) {
      return [
        oldWidget.flocalization != this.flocalization,
      ].any((v) => v);
    }
    return false;
  }
}
