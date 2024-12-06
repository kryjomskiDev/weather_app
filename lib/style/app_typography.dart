import 'package:flutter/material.dart';

class AppTypography {
  static const fontFamily = 'Inter';

  /// Body Regular
  static const bodyRegular = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    height: 1.5,
  );

  /// Body Medium Default
  static const bodyMediumDefault = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
  );

  /// Body Medium Underline
  static const bodyMediumUnderline = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    fontSize: 16,
    height: 1.5,
  );

  /// Footnote Regular
  static const footnoteRegular = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 1.42,
  );

  /// Footnote Medium
  static const footnoteMedium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.42,
    letterSpacing: -0.41,
  );

  /// Caption 1 Regular
  static const caption1Regular = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    height: 1.33,
  );

  /// Caption 1 Medium
  static const caption1Medium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.33,
  );

  /// Caption 1 SemiBold
  static const caption1SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 1.33,
  );

  /// Caption 2 Medium
  static const caption2Medium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.6,
  );

  /// Heading Large
  static const headingBig = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 64,
    height: 1.33,
  );

  /// Heading Large
  static const headingLarge = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.33,
  );

  /// Heading Medium
  static const headingMedium = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.33,
  );

  /// Heading Small
  static const headingSmall = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.5,
  );
}
