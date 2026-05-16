import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Inter';

  /// Body Regular
  static const TextStyle bodyRegular = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    height: 1.5,
  );

  /// Body Medium Default
  static const TextStyle bodyMediumDefault = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
  );

  /// Body Medium Underline
  static const TextStyle bodyMediumUnderline = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    fontSize: 16,
    height: 1.5,
  );

  /// Footnote Regular
  static const TextStyle footnoteRegular = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 1.42,
  );

  /// Footnote Medium
  static const TextStyle footnoteMedium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.42,
    letterSpacing: -0.41,
  );

  /// Caption 1 Regular
  static const TextStyle caption1Regular = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 1.33,
  );

  /// Caption 1 Medium
  static const TextStyle caption1Medium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.33,
  );

  /// Caption 1 SemiBold
  static const TextStyle caption1SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 1.33,
  );

  /// Caption 2 Medium
  static const TextStyle caption2Medium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.6,
  );

  /// Heading Large
  static const TextStyle headingLarge = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.33,
  );

  /// Heading Medium
  static const TextStyle headingMedium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.33,
  );

  /// Heading Small
  static const TextStyle headingSmall = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.5,
  );

  /// Heading Large
  static const TextStyle headingBig = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 64,
    height: 1.33,
  );

  /// Display Large
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 48,
    height: 1.33,
  );

  /// Display Medium
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 40,
    height: 1.33,
  );

  /// Display Small
  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 1.33,
  );
}
