import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';

class AppLoadingIndicator extends StatelessWidget with ExtensionMixin {
  final Color? color;

  const AppLoadingIndicator({
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: color ?? context.getColors().blue,
        ),
      );
}
