import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/locale/data_source/locale_data_source.dart';
import 'package:weather_app/data/locale/store/locale_store_impl.dart';
import 'package:weather_app/data/location/data_source/location_data_source.dart';
import 'package:weather_app/data/location/service/location_service_impl.dart';
import 'package:weather_app/data/weather/data_source/weather_api_data_source.dart';
import 'package:weather_app/data/weather/model/weather_details_dto.dart';
import 'package:weather_app/data/weather/model/weather_dto.dart';
import 'package:weather_app/data/weather/model/weather_temp_info_dto.dart';
import 'package:weather_app/data/weather/service/weather_service_impl.dart';
import 'package:weather_app/domain/locale/store/locale_store.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/pages/home/home_page.dart';
import 'package:weather_app/presentation/pages/settings/settings_page.dart';
import '../test/unit_tests/data/locale/store/locale_store_impl_test.mocks.dart';
import '../test/unit_tests/data/location/service/location_service_impl_test.mocks.dart';
import '../test/unit_tests/data/weather/service/weather_service_impl_test.mocks.dart';
import 'utils/integration_test_bootstrap.dart';

void main() {
  late WeatherApiDataSource weatherApiDataSource;
  late LocationDataSource locationDataSource;
  late LocaleDataSource localeDataSource;
  late WeatherService weatherService;
  late LocationService locationService;
  late LocaleStore localeStore;

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    weatherApiDataSource = MockWeatherApiDataSource();
    locationDataSource = MockLocationDataSource();
    localeDataSource = MockLocaleDataSource();

    weatherService = WeatherServiceImpl(weatherApiDataSource);
    locationService = LocationServiceImpl(locationDataSource);
    localeStore = LocaleStoreImpl(localeDataSource);
  });

  tearDown(getIt.reset);

  const currentWeather = WeatherDto(
    'Name',
    [WeatherDetailsDto('main', 'description', '04d')],
    WeatherTempInfoDto(20.0),
  );

  final currentPosition = Position(
    longitude: 20.0,
    latitude: 30.0,
    timestamp: DateTime.now(),
    accuracy: 10.0,
    altitude: 10.0,
    altitudeAccuracy: 10.0,
    heading: 10.0,
    headingAccuracy: 10.0,
    speed: 10.0,
    speedAccuracy: 10.0,
  );

  void simulateLoadedWeather() {
    when(locationDataSource.isLocationServiceEnabled()).thenAnswer((_) async => true);
    when(locationDataSource.checkLocationPermission()).thenAnswer(
      (_) async => LocationPermission.always,
    );
    when(localeDataSource.getSelectedLanguageCode()).thenReturn('en');
    when(locationDataSource.getCurrentLocation()).thenAnswer((_) async => currentPosition);
    when(weatherApiDataSource.getWeatherByCords(
      currentPosition.latitude,
      currentPosition.longitude,
      'en',
    )).thenAnswer((_) async => currentWeather);
  }

  Future<void> changeLanguage(WidgetTester tester, Key buttonKey) async {
    await tester.pump();
    await tester.tap(find.byKey(buttonKey));
    await tester.pumpAndSettle();
  }

  Future<void> navigateToSettingsPage(WidgetTester tester) async {
    await tester.pump();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
  }

  group('App Integration Test', () {
    testWidgets('navigates to settings page when Settings button is tapped on HomePage successfully',
        (WidgetTester tester) async {
      simulateLoadedWeather();
      await tester.bootstrapIntegrationTest(overrides: [
        () => registerOverride<WeatherService>(() => weatherService),
        () => registerOverride<LocationService>(() => locationService),
        () => registerOverride<LocaleStore>(() => localeStore),
      ]);
      await tester.pumpAndSettle();

      await navigateToSettingsPage(tester);

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
      await tester.pumpAndSettle();
    });

    testWidgets('changes languages successfully', (WidgetTester tester) async {
      simulateLoadedWeather();

      await tester.bootstrapIntegrationTest(overrides: [
        () => registerOverride<WeatherService>(() => weatherService),
        () => registerOverride<LocationService>(() => locationService),
      ]);

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);

      await changeLanguage(tester, const Key('pl-language-button'));
      expect(find.text('Język'), findsOneWidget);
      await changeLanguage(tester, const Key('en-language-button'));
      expect(find.text('Language'), findsOneWidget);
    });

    testWidgets('navigates back to HomePage when on SettingsPage successfully', (WidgetTester tester) async {
      simulateLoadedWeather();

      await tester.bootstrapIntegrationTest(overrides: [
        () => registerOverride<WeatherService>(() => weatherService),
        () => registerOverride<LocationService>(() => locationService),
        () => registerOverride<LocaleStore>(() => localeStore),
      ]);

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);

      await tester.pump();
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(SettingsPage), findsNothing);
    });
  });
}
