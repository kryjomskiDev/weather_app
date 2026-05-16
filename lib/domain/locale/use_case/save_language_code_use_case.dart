import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class SaveLanguageCodeUseCase {
  final LocaleStore _localeStore;

  const SaveLanguageCodeUseCase(this._localeStore);

  Future<Either<GenericError, void>> call(String languageCode) => _localeStore.saveLanguageCode(languageCode);
}
