import 'package:flutter/material.dart';
import 'package:weather_app/extensions/snackbar_extension.dart';
import 'package:weather_app/style/themes.dart';
import 'package:provider/provider.dart';

extension BuildContextUtils on BuildContext {
  AppTheme getColors({bool listen = true}) => Provider.of<ThemeModel>(this, listen: listen).getTheme;

  void showWeatherAppSnackBar({
    required String message,
    Color? backgroundColor,
    Color? textColor,
  }) => ScaffoldMessenger.of(this).showWeatherAppSnackBar(
    message: message,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
