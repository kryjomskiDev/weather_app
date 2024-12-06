import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';

@injectable
class GetSelectedLanguageCodeUseCase {
  final LocaleStore _localStore;

  const GetSelectedLanguageCodeUseCase(this._localStore);

  String? call() => _localStore.getSelectedLanguageCode();
}
