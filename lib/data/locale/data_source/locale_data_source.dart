import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/utils/shared_preferences_keys.dart';

@injectable
class LocaleDataSource {
  final SharedPreferences sharedPreferences;

  const LocaleDataSource(this.sharedPreferences);

  String? getSelectedLanguageCode() => sharedPreferences.getString(SharedPreferencesKeys.selectedLangaugeCode);

  Future<void> saveLanguageCode(String languageCode) =>
      sharedPreferences.setString(SharedPreferencesKeys.selectedLangaugeCode, languageCode);
}
