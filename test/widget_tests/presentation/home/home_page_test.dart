import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/domain/location/use_case/get_current_location_use_case.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_use_case.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/pages/home/body/home_body.dart';
import 'package:weather_app/presentation/pages/home/body/home_error_body.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/pages/home/home_page.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

import '../../utils/mock_router.dart';
import '../../utils/widget_test_bootstrap.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks(<Type>[
  GetCurrentWeatherUseCase,
  GetSelectedLanguageCodeUseCase,
  CheckLocationPermissionStatusUseCase,
  GetCurrentLocationUseCase,
])
void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late GetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;
  late CheckLocationPermissionStatusUseCase checkLocationPermissionStatusUseCase;
  late GetCurrentLocationUseCase getCurrentLocationUseCase;
  late HomeCubit homeCubit;

  setUp(() {
    getCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    getSelectedLanguageCodeUseCase = MockGetSelectedLanguageCodeUseCase();
    checkLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();
    getCurrentLocationUseCase = MockGetCurrentLocationUseCase();

    homeCubit = HomeCubit(
      getCurrentWeatherUseCase,
      getSelectedLanguageCodeUseCase,
      checkLocationPermissionStatusUseCase,
      getCurrentLocationUseCase,
    );

    when(getSelectedLanguageCodeUseCase()).thenReturn('en');
  });

  tearDown(getIt.reset);

  const CurrentWeather currentWeather = CurrentWeather(
    title: 'title',
    description: 'description',
    temperature: 20.0,
    icon: 'icon',
    locationName: 'locationName',
  );
  const CurrentLocation currentLocation = CurrentLocation(latitude: 10.0, longitude: 20.0);

  void simulateLoadedState({Duration? withDelay}) {
    when(checkLocationPermissionStatusUseCase()).thenAnswer(
      (_) async => Either.success(LocationPermissionStatus.granted),
    );
    when(getCurrentLocationUseCase()).thenAnswer((_) async => Either.success(currentLocation));
    when(
      getCurrentWeatherUseCase(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        languageCode: 'en',
      ),
    ).thenAnswer((_) async {
      if (withDelay != null) {
        await Future<void>.delayed(withDelay);
      }
      return Either.success(currentWeather);
    });
  }

  void simulateLocationDisabledState() {
    when(checkLocationPermissionStatusUseCase()).thenAnswer(
      (_) async => Either.failure(const LocationServiceDisabledError()),
    );
  }

  void simulatePermissionDeniedState() {
    when(checkLocationPermissionStatusUseCase()).thenAnswer(
      (_) async => Either.success(LocationPermissionStatus.denied),
    );
  }

  void simulateErrorBodyState() {
    when(checkLocationPermissionStatusUseCase()).thenAnswer(
      (_) async => Either.failure(const UnexpectedError()),
    );
  }

  testWidgets('HomePage displays loaded content correctly', (WidgetTester tester) async {
    simulateLoadedState();

    await tester.bootstrapWidgetTest(
      overrides: <void Function()>[() => registerOverride<HomeCubit>(() => homeCubit)],
      appRouter: getMockRouter(_homeRoute),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeBody), findsOneWidget);
    expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    expect(find.text('locationName'), findsOneWidget);
    expect(find.textContaining('20'), findsWidgets);
    expect(find.byIcon(Icons.do_not_disturb_alt_rounded), findsOneWidget);
    expect(find.text('title'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.byIcon(Icons.refresh_outlined), findsOneWidget);
  });

  testWidgets('HomePage displays location disabled error body', (WidgetTester tester) async {
    simulateLocationDisabledState();

    await tester.bootstrapWidgetTest(
      overrides: <void Function()>[() => registerOverride<HomeCubit>(() => homeCubit)],
      appRouter: getMockRouter(_homeRoute),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeLocationErrorBody), findsOneWidget);
    expect(find.text('Location is disabled, enable it to continue'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsOneWidget);
  });

  testWidgets('HomePage displays permission denied error body', (WidgetTester tester) async {
    simulatePermissionDeniedState();

    await tester.bootstrapWidgetTest(
      overrides: <void Function()>[() => registerOverride<HomeCubit>(() => homeCubit)],
      appRouter: getMockRouter(_homeRoute),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeLocationErrorBody), findsOneWidget);
    expect(find.text('Location permission is denied, grant it in system settings'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsOneWidget);
  });

  testWidgets('HomePage displays generic error body', (WidgetTester tester) async {
    simulateErrorBodyState();

    await tester.bootstrapWidgetTest(
      overrides: <void Function()>[() => registerOverride<HomeCubit>(() => homeCubit)],
      appRouter: getMockRouter(_homeRoute),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeLocationErrorBody), findsOneWidget);
    expect(find.text('Something went wrong, please try again'), findsOneWidget);
    expect(find.byType(WeatherAppFilledButton), findsOneWidget);
  });

  testWidgets('HomePage displays loader while loading', (WidgetTester tester) async {
    simulateLoadedState(withDelay: const Duration(seconds: 2));
    await tester.bootstrapWidgetTest(
      overrides: <void Function()>[() => registerOverride<HomeCubit>(() => homeCubit)],
      appRouter: getMockRouter(_homeRoute),
    );
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(WeatherAppLoadingIndicator), findsOneWidget);

    await tester.pumpAndSettle();
  });
}

final GoRoute _homeRoute = GoRoute(
  path: WeatherAppRoutes.home.path,
  name: WeatherAppRoutes.home.name,
  builder: (_, GoRouterState state) => const HomePage(),
);
