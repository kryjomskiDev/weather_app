import 'package:injectable/injectable.dart';
import 'package:weather_app/data/locale/data_source/locale_data_source.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';

@LazySingleton(as: LocaleStore)
class LocaleStoreImpl implements LocaleStore {
  final LocaleDataSource _localeInfoLocalDataSource;

  const LocaleStoreImpl(this._localeInfoLocalDataSource);

  @override
  String? getSelectedLanguageCode() => _localeInfoLocalDataSource.getSelectedLanguageCode();

  @override
  Future<void> saveLanguageCode(String languageCode) => _localeInfoLocalDataSource.saveLanguageCode(languageCode);
}
