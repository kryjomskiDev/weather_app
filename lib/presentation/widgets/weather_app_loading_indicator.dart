import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';

class WeatherAppLoadingIndicator extends StatelessWidget with ExtensionMixin {
  final Color? color;

  const WeatherAppLoadingIndicator({
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    label: Strings.of(context).a11yLoading,
    liveRegion: true,
    child: Center(
      child: CircularProgressIndicator(
        color: color ?? context.getColors().blue,
      ),
    ),
  );
}
