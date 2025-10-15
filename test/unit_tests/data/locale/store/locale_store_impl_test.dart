import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/locale/data_source/locale_data_source.dart';
import 'package:weather_app/data/locale/store/locale_store_impl.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';

import 'locale_store_impl_test.mocks.dart';

@GenerateMocks([LocaleDataSource])
void main() {
  late LocaleDataSource localeDataSource;
  late LocaleStore localeStore;

  setUp(() {
    localeDataSource = MockLocaleDataSource();
    localeStore = LocaleStoreImpl(localeDataSource);
  });

  group('LocaleStore', () {
    const languageCode = 'en';

    group('getSelectedLanguageCode method', () {
      test('should return selected language code from cache', () {
        when(localeDataSource.getSelectedLanguageCode()).thenReturn(languageCode);

        final result = localeStore.getSelectedLanguageCode();

        verify(localeDataSource.getSelectedLanguageCode()).called(1);
        expect(result, equals(languageCode));
      });

      test('should return null if no language code is selected', () {
        when(localeDataSource.getSelectedLanguageCode()).thenReturn(null);

        final result = localeStore.getSelectedLanguageCode();

        verify(localeDataSource.getSelectedLanguageCode()).called(1);
        expect(result, isNull);
      });
    });

    group('saveLanguageCode', () {
      test('should save language code in cache', () async {
        const languageCode = 'US';

        await localeDataSource.saveLanguageCode(languageCode);

        verify(localeDataSource.saveLanguageCode(languageCode)).called(1);
      });
    });
  });
}
