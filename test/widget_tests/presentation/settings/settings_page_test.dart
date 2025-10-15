import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/locale/use_case/save_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:weather_app/presentation/pages/settings/settings_page.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';
import 'package:weather_app/presentation/widgets/app_loading_indicator.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_radio_button.dart';

import '../../utils/mock_router.dart';
import '../../utils/widget_test_bootstrap.dart';
import 'settings_page_test.mocks.dart';

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

  tearDown(getIt.reset);
  const selectedLanguage = 'en';

  void simulateLoadedState({Duration? withDelay}) {
    when(getSelectedLanguageCodeUseCase()).thenReturn(selectedLanguage);
    when(checkLocationPermissionStatusUseCase()).thenAnswer((_) => Future.delayed(
          withDelay ?? Duration.zero,
          () => LocationPermissionStatus.always,
        ));
  }

  testWidgets('SettingsPage displays loaded content correctly', (WidgetTester tester) async {
    simulateLoadedState();
    await tester.bootstrapWidgetTest(
      overrides: [() => registerOverride<SettingsCubit>(() => settingsCubit)],
      appRouter: getMockRouter(_settingsRoute),
    );
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsOneWidget);
    expect(find.byType(WeatherAppRadioButton), findsExactly(2));
    expect(find.text('Location permission granted'), findsOneWidget);
    expect(find.text('To change location permissions, go to system settings'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsOneWidget);
  });

  testWidgets('Settings Page displays loader while loading', (WidgetTester tester) async {
    simulateLoadedState(withDelay: const Duration(seconds: 2));
    await tester.bootstrapWidgetTest(
      overrides: [() => registerOverride<SettingsCubit>(() => settingsCubit)],
      appRouter: getMockRouter(_settingsRoute),
    );
    await tester.pump();

    expect(find.byType(AppLoadingIndicator), findsOneWidget);
    await tester.pumpAndSettle();
  });
}

final _settingsRoute = GoRoute(
  path: '/${WeatherAppRoutes.settings.path}',
  name: WeatherAppRoutes.settings.name,
  builder: (_, state) => const SettingsPage(),
);
