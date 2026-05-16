import 'package:flutter/material.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/style/dimens.dart';

class WeatherAppCard extends StatelessWidget {
  final Widget child;

  const WeatherAppCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(Dimens.m),
    decoration: BoxDecoration(
      gradient: context.getColors().primaryCardGradient,
      borderRadius: BorderRadius.circular(Dimens.s),
    ),
    child: child,
  );
}
