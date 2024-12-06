import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/style/colors.dart';

class ThemeModel with ChangeNotifier {
  AppTheme _currentTheme = StandardTheme();

  AppTheme get getTheme => _currentTheme;

  void setTheme(themeMode) {
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
}
