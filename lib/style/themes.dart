import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/style/colors.dart';

class ThemeModel with ChangeNotifier {
  AppTheme _currentTheme = StandardTheme();

  AppTheme get getTheme => _currentTheme;

  void setTheme(AppTheme themeMode) {
    _currentTheme = themeMode;
    notifyListeners();
  }
}

abstract class AppTheme implements AppColorsBase {}

class StandardTheme extends AppTheme {
  @override
  Color get blue => AppStandardColors.blue;

  @override
  Color get white => AppStandardColors.white;

  @override
  Color get blueDeep => AppStandardColors.blueDeep;

  @override
  Color get blueLight => AppStandardColors.blueLight;

  @override
  Color get surfaceLight => AppStandardColors.surfaceLight;

  @override
  Color get accentYellow => AppStandardColors.accentYellow;

  @override
  Color get accentYellowDeep => AppStandardColors.accentYellowDeep;

  @override
  Color get textPrimary => AppStandardColors.textPrimary;

  @override
  Color get textSecondary => AppStandardColors.textSecondary;

  @override
  Color get shadowBlue => AppStandardColors.shadowBlue;

  @override
  LinearGradient get heroBackgroundGradient => AppStandardGradients.heroBackground;

  @override
  LinearGradient get primaryCardGradient => AppStandardGradients.primaryCard;

  @override
  Color get error => AppStandardColors.error;
}
