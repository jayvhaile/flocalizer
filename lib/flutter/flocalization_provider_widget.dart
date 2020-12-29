import 'package:flocalizer/flocalizer.dart';
import 'package:flutter/material.dart';

class FlocalizationProviderWidget extends StatelessWidget {
  final FlocalizationProvider provider;
  final WidgetBuilder builder;

  const FlocalizationProviderWidget({Key key, this.provider, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Flocalization>(
      stream: provider.flocalizationStream,
      builder: (context, snapshot) {
        return builder(context);
      },
    );
  }
}
