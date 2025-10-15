import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';
import 'package:weather_app/domain/locale/use_case/save_language_code_use_case.dart';

import 'save_language_code_use_case_test.mocks.dart';

@GenerateMocks([LocaleStore])
void main() {
  late LocaleStore localeStore;
  late SaveLanguageCodeUseCase saveLanguageCodeUseCase;

  setUp(() {
    localeStore = MockLocaleStore();
    saveLanguageCodeUseCase = SaveLanguageCodeUseCase(localeStore);
  });

  group('SaveLanguageCodeUseCase', () {
    const languageCode = 'en';

    test('invokes getSelectedLanguageCode in LocaleStore once', () async {
      await saveLanguageCodeUseCase(languageCode);

      verify(localeStore.saveLanguageCode(languageCode)).called(1);
    });
  });
}
