import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/locale/store/locale_store_impl.dart';
import 'package:weather_app/extensions/either_extensions.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocaleStoreImpl', () {
    late LocaleStoreImpl localeStore;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      localeStore = LocaleStoreImpl(prefs);
    });

    test('getSelectedLanguageCode returns null when unset', () {
      expect(localeStore.getSelectedLanguageCode().extractValueOrNull(), isNull);
    });

    test('saveLanguageCode persists value readable by getSelectedLanguageCode', () async {
      const String languageCode = 'en';

      await localeStore.saveLanguageCode(languageCode);

      expect(localeStore.getSelectedLanguageCode().extractValueOrNull(), equals(languageCode));
    });
  });
}
