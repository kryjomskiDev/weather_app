import 'package:flutter/material.dart';

/// Semantic color contract for the weather UI (light, blue-forward palette).
abstract class AppColorsBase {
  /// Main brand blue — hero backgrounds, primary cards, scaffold accents.
  Color get blue;

  /// Pure white — text on blue, card surfaces, icons on dark fills.
  Color get white;

  /// Deeper blue — gradient ends, pressed states, stronger contrast on blue.
  Color get blueDeep;

  /// Lighter blue — gradient starts, glass highlights.
  Color get blueLight;

  /// Airy page background — dashboard / forecast screens behind cards.
  Color get surfaceLight;

  /// Warm accent — primary CTAs, sun highlights, key emphasis.
  Color get accentYellow;

  /// Slightly deeper yellow — borders or pressed CTA states.
  Color get accentYellowDeep;

  /// Primary text on light surfaces (city names, large temps on pale bg).
  Color get textPrimary;

  /// Secondary / supporting text on light surfaces.
  Color get textSecondary;

  /// Soft translucent blue for elevated shadows / glass edges.
  Color get shadowBlue;

  Color get error;

  /// Gradient for large hero / onboarding blue areas.
  LinearGradient get heroBackgroundGradient;

  /// Gradient for “current weather” style primary cards.
  LinearGradient get primaryCardGradient;
}

/// Default palette aligned with a bright, friendly weather-app look
/// (vibrant blue, pale cool surfaces, golden yellow accents).
class AppStandardColors {
  AppStandardColors._();

  /// Primary vibrant blue — `#5C92FF`.
  static const Color blue = Color(0xFF5C92FF);

  static const Color white = Color(0xFFFFFFFF);

  /// Deeper blue for depth — `#3D6FE8`.
  static const Color blueDeep = Color(0xFF3D6FE8);

  /// Soft highlight blue — `#8EB8FF`.
  static const Color blueLight = Color(0xFF8EB8FF);

  /// Cool tinted off-white page background — `#E3F2FD`-style.
  static const Color surfaceLight = Color(0xFFE8F4FF);

  /// Sunny CTA / accent — `#FFD54F`.
  static const Color accentYellow = Color(0xFFFFD54F);

  /// Richer amber for emphasis on yellow — `#F9A825`.
  static const Color accentYellowDeep = Color(0xFFF9A825);

  /// Readable dark blue-grey on light cards — `#2C3E50`.
  static const Color textPrimary = Color(0xFF2C3E50);

  /// Muted label text — `#5C7A9C`.
  static const Color textSecondary = Color(0xFF5C7A9C);

  /// Soft blue shadow tint (~20% opacity on `#4A80F0`).
  static const Color shadowBlue = Color(0x334A80F0);

  static const Color error = Color(0xFFD0312D);
}

/// Reusable gradients built from [AppStandardColors].
class AppStandardGradients {
  AppStandardGradients._();

  static const LinearGradient heroBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      AppStandardColors.blueLight,
      AppStandardColors.blue,
      AppStandardColors.blueDeep,
    ],
    stops: <double>[0.0, 0.45, 1.0],
  );

  static const LinearGradient primaryCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppStandardColors.blueLight,
      AppStandardColors.blue,
      AppStandardColors.blueDeep,
    ],
  );
}
