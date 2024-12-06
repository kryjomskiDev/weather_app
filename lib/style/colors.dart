import 'package:flutter/material.dart';

abstract class AppTheme implements AppColorsBase {}

abstract class AppColorsBase {
  Color get blue;
  Color get white;
}

class AppStandardColors {
  static const Color blue = Color(0xFF3b3aef);

  static const Color white = Color(0xFFffffff);
}
