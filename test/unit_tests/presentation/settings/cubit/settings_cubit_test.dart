import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/locale/use_case/save_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_state.dart';

import 'settings_cubit_test.mocks.dart';

@GenerateMocks([
  GetSelectedLanguageCodeUseCase,
  SaveLanguageCodeUseCase,
  CheckLocationPermissionStatusUseCase,
])
void main() {
  late GetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;
  late SaveLanguageCodeUseCase saveLanguageCodeUseCase;
  late CheckLocationPermissionStatusUseCase checkLocationPermissionStatusUseCase;
  late SettingsCubit settingsCubit;

  setUp(() {
    getSelectedLanguageCodeUseCase = MockGetSelectedLanguageCodeUseCase();
    saveLanguageCodeUseCase = MockSaveLanguageCodeUseCase();
    checkLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();

    settingsCubit = SettingsCubit(
      getSelectedLanguageCodeUseCase,
      saveLanguageCodeUseCase,
      checkLocationPermissionStatusUseCase,
    );
  });

  group('SettingsCubit', () {
    test(
      'has initial idle state',
      () => expect(settingsCubit.state, const SettingsState.idle()),
    );

    group('init method', () {
      const selectedLanguage = 'en';
      blocTest(
        'emits [loading, loaded] states successfully',
        setUp: () {
          when(getSelectedLanguageCodeUseCase()).thenReturn(selectedLanguage);
          when(checkLocationPermissionStatusUseCase()).thenAnswer((_) async => LocationPermissionStatus.always);
        },
        build: () => settingsCubit,
        act: (cubit) => cubit.init(),
        expect: () => [
          const SettingsState.loading(),
          const SettingsState.loaded(
            selectedLanguageCode: selectedLanguage,
            locationPermissionStatus: LocationPermissionStatus.always,
          ),
        ],
      );

      blocTest(
        'emits [loading, error] when an exception occurs',
        setUp: () {
          when(getSelectedLanguageCodeUseCase()).thenThrow(Exception('Some error'));
        },
        build: () => settingsCubit,
        act: (cubit) => cubit.init(),
        expect: () => [
          const SettingsState.loading(),
          const SettingsState.error(),
        ],
      );
    });

    group('selectLanguage method', () {
      const newSelectedLanguage = 'pl';
      blocTest(
        'emits [loading, languageSelected] states successfully',
        setUp: () {
          when(saveLanguageCodeUseCase(newSelectedLanguage)).thenAnswer(
            (_) => Future.value(),
          );
        },
        build: () => settingsCubit,
        act: (cubit) => cubit.selectLanguage(newSelectedLanguage),
        expect: () => [
          const SettingsState.loading(),
          const SettingsState.languageSelected(),
        ],
      );

      blocTest(
        'emits [loading, error] when an exception occurs',
        setUp: () {
          when(saveLanguageCodeUseCase(newSelectedLanguage)).thenThrow(Exception('Some error'));
        },
        build: () => settingsCubit,
        act: (cubit) => cubit.selectLanguage(newSelectedLanguage),
        expect: () => [
          const SettingsState.loading(),
          const SettingsState.error(),
        ],
      );
    });

    group('onLanguageSelected method', () {
      const selectedLanguage = 'en';
      const newLanguage = 'pl';
      const locationPermissionStatus = LocationPermissionStatus.always;

      blocTest(
        'emits [loaded] state with current values',
        build: () => settingsCubit,
        setUp: () async {
          when(getSelectedLanguageCodeUseCase()).thenReturn(selectedLanguage);
          when(checkLocationPermissionStatusUseCase()).thenAnswer((_) async => locationPermissionStatus);
          when(saveLanguageCodeUseCase(newLanguage)).thenAnswer((_) => Future.value());

          await settingsCubit.init();
          await settingsCubit.selectLanguage(newLanguage);
        },
        act: (cubit) => cubit.onLanguageSelected(),
        expect: () => [
          const SettingsState.loaded(
            selectedLanguageCode: newLanguage,
            locationPermissionStatus: locationPermissionStatus,
          ),
        ],
      );
    });
  });
}
