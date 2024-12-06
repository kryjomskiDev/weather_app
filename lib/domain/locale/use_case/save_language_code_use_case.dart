import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';

@injectable
class SaveLanguageCodeUseCase {
  final LocaleStore _localeStore;

  const SaveLanguageCodeUseCase(this._localeStore);

  Future<void> call(String languageCode) => _localeStore.saveLanguageCode(languageCode);
}
