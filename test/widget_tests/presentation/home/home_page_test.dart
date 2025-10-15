import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/domain/location/use_case/get_current_location_use_case.dart';
import 'package:weather_app/domain/location/use_case/is_location_service_enabled_use_case.dart';
import 'package:weather_app/domain/location/use_case/request_location_permission_use_case.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_use_case.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/pages/home/body/home_body.dart';
import 'package:weather_app/presentation/pages/home/body/home_error_body.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/widgets/app_loading_indicator.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';

import '../../utils/widget_test_bootstrap.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([
  GetCurrentWeatherUseCase,
  GetSelectedLanguageCodeUseCase,
  IsLocationServiceEnabledUseCase,
  CheckLocationPermissionStatusUseCase,
  RequestLocationPermissionUseCase,
  GetCurrentLocationUseCase,
])
void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late GetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;
  late IsLocationServiceEnabledUseCase isLocationServiceEnabledUseCase;
  late CheckLocationPermissionStatusUseCase checkLocationPermissionStatusUseCase;
  late RequestLocationPermissionUseCase requestLocationPermissionUseCase;
  late GetCurrentLocationUseCase getCurrentLocationUseCase;
  late HomeCubit homeCubit;

  setUp(() {
    getCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    getSelectedLanguageCodeUseCase = MockGetSelectedLanguageCodeUseCase();
    isLocationServiceEnabledUseCase = MockIsLocationServiceEnabledUseCase();
    checkLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();
    requestLocationPermissionUseCase = MockRequestLocationPermissionUseCase();
    getCurrentLocationUseCase = MockGetCurrentLocationUseCase();

    homeCubit = HomeCubit(
      getCurrentWeatherUseCase,
      getSelectedLanguageCodeUseCase,
      isLocationServiceEnabledUseCase,
      checkLocationPermissionStatusUseCase,
      requestLocationPermissionUseCase,
      getCurrentLocationUseCase,
    );
  });

  tearDown(getIt.reset);

  const currentWeather = CurrentWeather(
    title: 'title',
    description: 'description',
    temperature: 20.0,
    icon: 'icon',
    locationName: 'locationName',
  );
  const currentLocation = CurrentLocation(latitude: 10.0, longitude: 20.0);

  void simulateLoadedState({Duration? withDelay}) {
    when(isLocationServiceEnabledUseCase()).thenAnswer((_) async => true);
    when(checkLocationPermissionStatusUseCase()).thenAnswer(
      (_) async => LocationPermissionStatus.always,
    );
    when(getSelectedLanguageCodeUseCase()).thenReturn('en');
    when(getCurrentLocationUseCase()).thenAnswer((_) async => currentLocation);
    when(getCurrentWeatherUseCase(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
      languageCode: 'en',
    )).thenAnswer((_) => Future.delayed(
          withDelay ?? Duration.zero,
          () => currentWeather,
        ));
  }

  void simulateLocationDisabledState() => when(isLocationServiceEnabledUseCase()).thenAnswer((_) async => false);

  void simulatePermissionDeniedState() {
    when(isLocationServiceEnabledUseCase()).thenAnswer((_) async => true);
    when(checkLocationPermissionStatusUseCase()).thenAnswer(
      (_) async => LocationPermissionStatus.denied,
    );
    when(requestLocationPermissionUseCase()).thenAnswer(
      (_) async => LocationPermissionStatus.denied,
    );
  }

  void simulateErrorBodyState() => when(isLocationServiceEnabledUseCase()).thenThrow(Exception());

  testWidgets('HomePage displays loaded content correctly', (WidgetTester tester) async {
    simulateLoadedState();

    await tester.bootstrapWidgetTest(overrides: [
      () => registerOverride<HomeCubit>(() => homeCubit),
    ]);
    await tester.pumpAndSettle();

    expect(find.byType(HomeBody), findsOneWidget);
    expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    expect(find.text('locationName'), findsOneWidget);
    expect(find.text('20°C'), findsOneWidget);
    expect(find.byIcon(Icons.do_not_disturb_alt_rounded), findsOneWidget);
    expect(find.text('title'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsExactly(2));
  });

  testWidgets('HomePage displays location disabled error body', (WidgetTester tester) async {
    simulateLocationDisabledState();

    await tester.bootstrapWidgetTest(overrides: [
      () => registerOverride<HomeCubit>(() => homeCubit),
    ]);
    await tester.pumpAndSettle();

    expect(find.byType(HomeLocationErrorBody), findsOneWidget);
    expect(find.text('Location is disabled, enable it to continue'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsExactly(2));
  });

  testWidgets('HomePage displays permission denied error body', (WidgetTester tester) async {
    simulatePermissionDeniedState();

    await tester.bootstrapWidgetTest(overrides: [
      () => registerOverride<HomeCubit>(() => homeCubit),
    ]);
    await tester.pumpAndSettle();

    expect(find.byType(HomeLocationErrorBody), findsOneWidget);
    expect(find.text('Location permission is denied, grant it in system settings'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsExactly(2));
  });

  testWidgets('HomePage displays generic error body', (WidgetTester tester) async {
    simulateErrorBodyState();

    await tester.bootstrapWidgetTest(overrides: [
      () => registerOverride<HomeCubit>(() => homeCubit),
    ]);
    await tester.pumpAndSettle();

    expect(find.byType(HomeLocationErrorBody), findsOneWidget);
    expect(find.text('Something went wrong, please try again'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsExactly(2));
  });

  testWidgets('HomePage displays loader while loading', (WidgetTester tester) async {
    simulateLoadedState(withDelay: const Duration(seconds: 2));
    await tester.bootstrapWidgetTest(overrides: [
      () => registerOverride<HomeCubit>(() => homeCubit),
    ]);
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(AppLoadingIndicator), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
