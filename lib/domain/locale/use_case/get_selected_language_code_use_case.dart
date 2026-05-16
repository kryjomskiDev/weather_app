import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';
import 'package:weather_app/extensions/either_extensions.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/l10n_model.dart';

@injectable
class GetSelectedLanguageCodeUseCase {
  final LocaleStore _localStore;

  const GetSelectedLanguageCodeUseCase(this._localStore);

  String call() {
    final Either<GenericError, String?> result = _localStore.getSelectedLanguageCode();

    final String selectedLanguageCode = result.extractValueOrNull() ?? englishLanguageCode;

    return selectedLanguageCode;
  }
}
