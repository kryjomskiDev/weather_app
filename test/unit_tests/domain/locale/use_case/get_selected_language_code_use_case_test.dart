import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/utils/error_handling/either.dart';

import 'get_selected_language_code_use_case_test.mocks.dart';

@GenerateMocks(<Type>[LocaleStore])
void main() {
  late LocaleStore localeStore;
  late GetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;

  setUp(() {
    localeStore = MockLocaleStore();
    getSelectedLanguageCodeUseCase = GetSelectedLanguageCodeUseCase(localeStore);
  });

  group('GetSelectedLanguageCodeUseCase', () {
    const String languageCode = 'en';

    test('invokes getSelectedLanguageCode in LocaleStore once', () {
      when(localeStore.getSelectedLanguageCode()).thenReturn(Either.success(languageCode));

      getSelectedLanguageCodeUseCase();

      verify(localeStore.getSelectedLanguageCode()).called(1);
    });
  });
}
