import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/domain/location/use_case/get_current_location_use_case.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_use_case.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

import 'home_cubit_test.mocks.dart';

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

  group('HomeCubit', () {
    test(
      'has initial loading state',
      () => expect(homeCubit.state, const HomeStateLoading()),
    );

    group('init method', () {
      const CurrentWeather currentWeather = CurrentWeather(
        title: 'title',
        description: 'description',
        temperature: 20.0,
        icon: 'icon',
        locationName: 'locationName',
      );

      const CurrentLocation currentLocation = CurrentLocation(latitude: 10.0, longitude: 20.0);

      blocTest(
        'emits [loading, error] when location permission check fails',
        setUp: () {
          when(checkLocationPermissionStatusUseCase()).thenAnswer(
            (_) async => Either.failure(
              const UnexpectedError(message: 'Some error'),
            ),
          );
        },
        build: () => homeCubit,
        act: (HomeCubit cubit) => cubit.init(),
        expect: () => <HomeState>[
          const HomeStateLoading(),
          const HomeStateError(error: UnexpectedError(message: 'Some error')),
        ],
      );

      blocTest(
        'emits [loading, error] when permission is denied',
        setUp: () {
          when(checkLocationPermissionStatusUseCase()).thenAnswer(
            (_) async => Either.success(LocationPermissionStatus.denied),
          );
        },
        build: () => homeCubit,
        act: (HomeCubit cubit) => cubit.init(),
        expect: () => <HomeState>[
          const HomeStateLoading(),
          const HomeStateError(error: LocationPermissionDeniedForeverError()),
        ],
      );

      blocTest(
        'emits [loading, loaded] when permissions are granted and weather is fetched successfully',
        setUp: () {
          when(checkLocationPermissionStatusUseCase()).thenAnswer(
            (_) async => Either.success(LocationPermissionStatus.granted),
          );
          when(getSelectedLanguageCodeUseCase()).thenReturn('en');
          when(getCurrentLocationUseCase()).thenAnswer((_) async => Either.success(currentLocation));
          when(
            getCurrentWeatherUseCase(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude,
              languageCode: 'en',
            ),
          ).thenAnswer((_) async => Either.success(currentWeather));
        },
        build: () => homeCubit,
        act: (HomeCubit cubit) => cubit.init(),
        expect: () => <HomeState>[
          const HomeStateLoading(),
          const HomeStateLoaded(currentWeather: currentWeather),
        ],
      );

      blocTest(
        'emits [loading with prior weather, loaded] when isRefreshPage is true and weather is fetched successfully',
        setUp: () {
          when(checkLocationPermissionStatusUseCase()).thenAnswer(
            (_) async => Either.success(LocationPermissionStatus.granted),
          );
          when(getSelectedLanguageCodeUseCase()).thenReturn('en');
          when(getCurrentLocationUseCase()).thenAnswer((_) async => Either.success(currentLocation));
          when(
            getCurrentWeatherUseCase(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude,
              languageCode: 'en',
            ),
          ).thenAnswer((_) async => Either.success(currentWeather));
        },
        build: () => homeCubit,
        act: (HomeCubit cubit) async {
          await homeCubit.init();
          await cubit.init(isRefreshPage: true);
        },
        expect: () => <HomeState>[
          const HomeStateLoading(),
          const HomeStateLoaded(currentWeather: currentWeather),
          const HomeStateLoading(currentWeather: currentWeather),
          const HomeStateLoaded(currentWeather: currentWeather),
        ],
      );
    });
  });
}
