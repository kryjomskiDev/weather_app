import 'package:flutter/material.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/style/app_typography.dart';

class WeatherAppTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  const WeatherAppTextButton({
    required this.title,
    this.onTap,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Text(
      title,
      textAlign: TextAlign.center,
      style:
          textStyle ??
          AppTypography.bodyMediumDefault.copyWith(
            color: context.getColors().white,
            decoration: TextDecoration.underline,
            decorationColor: context.getColors().white,
          ),
    ),
  );
}
