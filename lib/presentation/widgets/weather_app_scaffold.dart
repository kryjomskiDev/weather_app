import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';

class WeatherAppScaffold extends StatelessWidget with ExtensionMixin {
  final Widget body;

  const WeatherAppScaffold({
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.getColors().blue,
        body: SafeArea(child: body),
      );
}
