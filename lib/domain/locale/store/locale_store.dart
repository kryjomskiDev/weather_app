import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

abstract interface class LocaleStore {
  Either<GenericError, String?> getSelectedLanguageCode();

  Future<Either<GenericError, void>> saveLanguageCode(String languageCode);
}
