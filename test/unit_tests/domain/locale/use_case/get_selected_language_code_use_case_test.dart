import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';

import 'get_selected_language_code_use_case_test.mocks.dart';

@GenerateMocks([LocaleStore])
void main() {
  late LocaleStore localeStore;
  late GetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;

  setUp(() {
    localeStore = MockLocaleStore();
    getSelectedLanguageCodeUseCase = GetSelectedLanguageCodeUseCase(localeStore);
  });

  group('GetSelectedLanguageCodeUseCase', () {
    const languageCode = 'en';

    test('invokes getSelectedLanguageCode in LocaleStore once', () {
      when(localeStore.getSelectedLanguageCode()).thenReturn(languageCode);

      getSelectedLanguageCodeUseCase();

      verify(localeStore.getSelectedLanguageCode()).called(1);
    });
  });
}
