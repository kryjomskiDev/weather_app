import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/utils/shared_preferences_keys.dart';

const String defaultLanguageCode = englishLanguageCode;
const String englishLanguageCode = 'en';
const String polishLanguageCode = 'pl';

class L10nModel with ChangeNotifier {
  final SharedPreferences _sharedPreferences;

  late String preferredLanguageCode;

  L10nModel(this._sharedPreferences) {
    _getLanguageCode();
  }

  void switchLanguage() {
    _getLanguageCode();
    notifyListeners();
  }

  void _getLanguageCode() {
    final String? selectedLanguageCode = _sharedPreferences.getString(SharedPreferencesKeys.selectedLangaugeCode);

    preferredLanguageCode = selectedLanguageCode ?? defaultLanguageCode;
  }
}
