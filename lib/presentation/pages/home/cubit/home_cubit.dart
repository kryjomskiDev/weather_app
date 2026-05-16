import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/domain/location/use_case/get_current_location_use_case.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_use_case.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class HomeCubit extends SafetyCubit<HomeState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final GetSelectedLanguageCodeUseCase _getSelectedLanguageCodeUseCase;
  final CheckLocationPermissionStatusUseCase _checkLocationPermissionStatusUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;

  HomeCubit(
    this._getCurrentWeatherUseCase,
    this._getSelectedLanguageCodeUseCase,
    this._checkLocationPermissionStatusUseCase,
    this._getCurrentLocationUseCase,
  ) : super(const HomeStateLoading());

  late String _selectedLanguageCode;
  late CurrentLocation _currentLocation;
  late CurrentWeather _currentWeather;

  Future<void> init({bool isRefreshPage = false}) async {
    isRefreshPage ? emit(HomeStateLoading(currentWeather: _currentWeather)) : emit(const HomeStateLoading());

    _selectedLanguageCode = _getSelectedLanguageCodeUseCase();

    final Either<GenericError, LocationPermissionStatus> result = await _checkLocationPermissionStatusUseCase();

    await result.fold(
      (GenericError error) async => emit(HomeStateError(error: error)),
      (LocationPermissionStatus permissionStatus) async {
        if (permissionStatus == LocationPermissionStatus.granted) {
          await _onLocationPermissionGranted();
        } else {
          emit(const HomeStateError(error: LocationPermissionDeniedForeverError()));
        }
      },
    );
  }

  Future<void> _onLocationPermissionGranted() async {
    final Either<GenericError, CurrentLocation> currentLocationResult = await _getCurrentLocationUseCase();

    await currentLocationResult.fold(
      (GenericError error) async => emit(HomeStateError(error: error)),
      (CurrentLocation currentLocation) async {
        _currentLocation = currentLocation;
        await _getWeatherForCurrentLocation();
      },
    );
  }

  Future<void> _getWeatherForCurrentLocation() async {
    final Either<GenericError, CurrentWeather> currentWeatherResult = await _getCurrentWeatherUseCase(
      latitude: _currentLocation.latitude,
      longitude: _currentLocation.longitude,
      languageCode: _selectedLanguageCode,
    );

    currentWeatherResult.fold(
      (GenericError error) => emit(HomeStateError(error: error)),
      (CurrentWeather currentWeather) {
        _currentWeather = currentWeather;
        emit(HomeStateLoaded(currentWeather: currentWeather));
      },
    );
  }
}
