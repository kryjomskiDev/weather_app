import 'package:bloc_test/bloc_test.dart';
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
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_state.dart';

import 'home_cubit_test.mocks.dart';

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

  group('HomeCubit', () {
    test(
      'has initial idle state',
      () => expect(homeCubit.state, const HomeState.idle()),
    );

    group('init method', () {
      const currentWeather = CurrentWeather(
        title: 'title',
        description: 'description',
        temperature: 20.0,
        icon: 'icon',
        locationName: 'locationName',
      );

      const currentLocation = CurrentLocation(latitude: 10.0, longitude: 20.0);

      blocTest(
        'emits [loading, locationDisabled] state when location is disabled',
        setUp: () async {
          when(isLocationServiceEnabledUseCase()).thenAnswer((_) async => false);
        },
        build: () => homeCubit,
        act: (cubit) => cubit.init(),
        expect: () => [
          const HomeState.loading(),
          const HomeState.locationDisabled(),
        ],
      );

      blocTest(
        'emits [loading, locationPermissionDenied] state when location permission is denied',
        setUp: () async {
          when(isLocationServiceEnabledUseCase()).thenAnswer((_) async => true);
          when(checkLocationPermissionStatusUseCase()).thenAnswer((_) async => LocationPermissionStatus.denied);
          when(requestLocationPermissionUseCase()).thenAnswer((_) async => LocationPermissionStatus.denied);
        },
        build: () => homeCubit,
        act: (cubit) => cubit.init(),
        expect: () => [
          const HomeState.loading(),
          const HomeState.locationPermissionDenied(),
        ],
      );

      blocTest(
        'emits [loading, locationPermissionDenied] state when location permission is deniedForever',
        setUp: () async {
          when(isLocationServiceEnabledUseCase()).thenAnswer((_) async => true);
          when(checkLocationPermissionStatusUseCase()).thenAnswer((_) async => LocationPermissionStatus.deniedForever);
        },
        build: () => homeCubit,
        act: (cubit) => cubit.init(),
        expect: () => [
          const HomeState.loading(),
          const HomeState.locationPermissionDenied(),
        ],
      );

      blocTest(
        'emits [loading, loaded] when permissions are granted and weather is fetched successfully',
        setUp: () async {
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
          )).thenAnswer((_) async => currentWeather);
        },
        build: () => homeCubit,
        act: (cubit) => cubit.init(),
        expect: () => [
          const HomeState.loading(),
          const HomeState.loaded(currentWeather: currentWeather),
        ],
      );

      blocTest(
        'emits [refreshPage, loaded] when isRefreshPage is true and weather is fetched successfully',
        setUp: () async {
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
          )).thenAnswer((_) async => currentWeather);

          await homeCubit.init();
        },
        build: () => homeCubit,
        act: (cubit) => cubit.init(isRefreshPage: true),
        expect: () => [
          const HomeState.refreshPage(currentWeather: currentWeather),
          const HomeState.loaded(currentWeather: currentWeather),
        ],
      );

      blocTest(
        'emits [loading, error] when an exception occurs',
        setUp: () async {
          when(isLocationServiceEnabledUseCase()).thenThrow(Exception('Some error'));
        },
        build: () => homeCubit,
        act: (cubit) => cubit.init(),
        expect: () => [
          const HomeState.loading(),
          const HomeState.error(),
        ],
      );
    });

    group('goToSettings', () {
      blocTest(
        'emits [idle, goToSettings] state',
        build: () => homeCubit,
        act: (cubit) => cubit.goToSettings(),
        expect: () => [
          const HomeState.idle(),
          const HomeState.goToSettings(),
        ],
      );
    });
  });
}
