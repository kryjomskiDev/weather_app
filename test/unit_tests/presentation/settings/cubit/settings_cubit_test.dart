import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/auth/use_case/sign_out_use_case.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/locale/use_case/save_language_code_use_case.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_presentation_event.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

import 'settings_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  GetSelectedLanguageCodeUseCase,
  SaveLanguageCodeUseCase,
  SignOutUseCase,
])
void main() {
  late MockSignOutUseCase signOutUseCase;
  late MockGetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;
  late MockSaveLanguageCodeUseCase saveLanguageCodeUseCase;

  setUp(() {
    signOutUseCase = MockSignOutUseCase();
    getSelectedLanguageCodeUseCase = MockGetSelectedLanguageCodeUseCase();
    saveLanguageCodeUseCase = MockSaveLanguageCodeUseCase();
  });

  SettingsCubit buildCubit() => SettingsCubit(
    signOutUseCase,
    getSelectedLanguageCodeUseCase,
    saveLanguageCodeUseCase,
  );

  group('SettingsCubit', () {
    test('has initial loading state', () => expect(buildCubit().state, const SettingsStateLoading()));

    group('init method', () {
      const String selectedLanguage = 'en';

      blocTest(
        'emits [loading, loaded] states successfully',
        setUp: () {
          when(getSelectedLanguageCodeUseCase()).thenReturn(selectedLanguage);
        },
        build: buildCubit,
        act: (SettingsCubit cubit) => cubit.init(),
        expect: () => <SettingsState>[
          const SettingsStateLoading(),
          const SettingsStateLoaded(selectedLanguageCode: selectedLanguage),
        ],
      );
    });

    group('selectLanguage method', () {
      const String newSelectedLanguage = 'pl';

      blocTest(
        'emits [loaded, loading] then presentation on success until onLanguageSelected',
        setUp: () {
          when(getSelectedLanguageCodeUseCase()).thenReturn('en');
          when(saveLanguageCodeUseCase(newSelectedLanguage)).thenAnswer(
            (_) async => Either.success<void>(null),
          );
        },
        build: buildCubit,
        act: (SettingsCubit cubit) async {
          await cubit.init();
          await cubit.selectLanguage(newSelectedLanguage);
        },
        expect: () => <SettingsState>[
          const SettingsStateLoading(),
          const SettingsStateLoaded(selectedLanguageCode: 'en'),
          const SettingsStateLoading(),
        ],
      );

      blocTest(
        'emits [loading, error] when save fails',
        setUp: () {
          when(saveLanguageCodeUseCase(newSelectedLanguage)).thenAnswer(
            (_) async => Either.failure<void>(
              const UnexpectedError(message: 'Some error'),
            ),
          );
        },
        build: buildCubit,
        act: (SettingsCubit cubit) => cubit.selectLanguage(newSelectedLanguage),
        expect: () => <SettingsState>[
          const SettingsStateLoading(),
          const SettingsStateError(),
        ],
      );
    });

    group('onLanguageSelected method', () {
      blocTest(
        'emits [loaded] with saved language after selectLanguage success',
        setUp: () {
          when(getSelectedLanguageCodeUseCase()).thenReturn('en');
          when(saveLanguageCodeUseCase('pl')).thenAnswer(
            (_) async => Either.success<void>(null),
          );
        },
        build: buildCubit,
        act: (SettingsCubit cubit) async {
          await cubit.init();
          await cubit.selectLanguage('pl');
          cubit.onLanguageSelected();
        },
        expect: () => <SettingsState>[
          const SettingsStateLoading(),
          const SettingsStateLoaded(selectedLanguageCode: 'en'),
          const SettingsStateLoading(),
          const SettingsStateLoaded(selectedLanguageCode: 'pl'),
        ],
      );
    });

    group('logout method', () {
      test('emits LogoutFailedEvent when signOut fails', () async {
        when(signOutUseCase()).thenAnswer(
          (_) async => Either.failure<void>(
            const UnexpectedError(message: 'sign out failed'),
          ),
        );

        final SettingsCubit cubit = buildCubit();
        final List<SettingsPresentationEvent> events = <SettingsPresentationEvent>[];
        final StreamSubscription<SettingsPresentationEvent> sub = cubit.presentation.listen(events.add);

        await cubit.logout();
        await pumpEventQueue();

        expect(events, contains(const LogoutFailedEvent()));
        await sub.cancel();
        await cubit.close();
      });

      test('does not emit LogoutFailedEvent when signOut succeeds', () async {
        when(signOutUseCase()).thenAnswer(
          (_) async => Either.success<void>(null),
        );

        final SettingsCubit cubit = buildCubit();
        final List<SettingsPresentationEvent> events = <SettingsPresentationEvent>[];
        final StreamSubscription<SettingsPresentationEvent> sub = cubit.presentation.listen(events.add);

        await cubit.logout();
        await pumpEventQueue();

        expect(events, isNot(contains(const LogoutFailedEvent())));
        await sub.cancel();
        await cubit.close();
      });
    });
  });
}
