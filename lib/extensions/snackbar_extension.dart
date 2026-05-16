import 'package:flutter/material.dart';
import 'package:weather_app/style/app_typography.dart';

extension WeatherAppSnackbarExtension on ScaffoldMessengerState {
  void showWeatherAppSnackBar({
    required String message,
    Color? backgroundColor,
    Color? textColor,
  }) {
    hideCurrentSnackBar();
    showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTypography.bodyMediumDefault.copyWith(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
