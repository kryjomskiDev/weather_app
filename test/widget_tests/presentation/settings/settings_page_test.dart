import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/auth/use_case/sign_out_use_case.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/locale/use_case/save_language_code_use_case.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:weather_app/presentation/pages/settings/settings_page.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_radio_button.dart';

import '../../utils/mock_router.dart';
import '../../utils/widget_test_bootstrap.dart';
import 'settings_page_test.mocks.dart';

@GenerateMocks(<Type>[
  GetSelectedLanguageCodeUseCase,
  SaveLanguageCodeUseCase,
  SignOutUseCase,
])
void main() {
  late MockSignOutUseCase signOutUseCase;
  late MockGetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;
  late MockSaveLanguageCodeUseCase saveLanguageCodeUseCase;
  late SettingsCubit settingsCubit;

  setUp(() {
    signOutUseCase = MockSignOutUseCase();
    getSelectedLanguageCodeUseCase = MockGetSelectedLanguageCodeUseCase();
    saveLanguageCodeUseCase = MockSaveLanguageCodeUseCase();

    settingsCubit = SettingsCubit(
      signOutUseCase,
      getSelectedLanguageCodeUseCase,
      saveLanguageCodeUseCase,
    );
  });

  tearDown(getIt.reset);
  const String selectedLanguage = 'en';

  void simulateLoadedState({Duration? saveDelay}) {
    when(getSelectedLanguageCodeUseCase()).thenReturn(selectedLanguage);
    when(saveLanguageCodeUseCase(any)).thenAnswer(
      (_) async {
        if (saveDelay != null) {
          await Future<void>.delayed(saveDelay);
        }
        return Either.success<void>(null);
      },
    );
    when(signOutUseCase()).thenAnswer((_) async => Either.success<void>(null));
  }

  testWidgets('SettingsPage displays loaded content correctly', (WidgetTester tester) async {
    simulateLoadedState();
    await tester.bootstrapWidgetTest(
      overrides: <void Function()>[() => registerOverride<SettingsCubit>(() => settingsCubit)],
      appRouter: getMockRouter(_settingsRoute),
    );
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsOneWidget);
    expect(find.byType(WeatherAppRadioButton), findsExactly(2));
    expect(find.text('Log out'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsOneWidget);
  });

  testWidgets('Settings Page displays loader while saving language', (WidgetTester tester) async {
    simulateLoadedState(saveDelay: const Duration(seconds: 2));
    await tester.bootstrapWidgetTest(
      overrides: <void Function()>[() => registerOverride<SettingsCubit>(() => settingsCubit)],
      appRouter: getMockRouter(_settingsRoute),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('pl-language-button')));
    await tester.pump();

    expect(find.byType(WeatherAppLoadingIndicator), findsOneWidget);
    await tester.pumpAndSettle();
  });
}

final GoRoute _settingsRoute = GoRoute(
  path: WeatherAppRoutes.settings.path,
  name: WeatherAppRoutes.settings.name,
  builder: (_, GoRouterState state) => const SettingsPage(),
);
