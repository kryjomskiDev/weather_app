import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';
import 'package:weather_app/utils/shared_preferences_keys.dart';

@LazySingleton(as: LocaleStore)
class LocaleStoreImpl implements LocaleStore {
  final SharedPreferences sharedPreferences;

  const LocaleStoreImpl(this.sharedPreferences);

  @override
  Either<GenericError, String?> getSelectedLanguageCode() {
    try {
      final String? selectedLanguageCode = sharedPreferences.getString(SharedPreferencesKeys.selectedLangaugeCode);
      return Either.success(selectedLanguageCode);
    } catch (e) {
      return Either.failure(const UnexpectedError(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<GenericError, void>> saveLanguageCode(String languageCode) async {
    try {
      await sharedPreferences.setString(SharedPreferencesKeys.selectedLangaugeCode, languageCode);
      return Either.success(null);
    } catch (e) {
      return Either.failure(const UnexpectedError(message: 'An unexpected error occurred'));
    }
  }
}
