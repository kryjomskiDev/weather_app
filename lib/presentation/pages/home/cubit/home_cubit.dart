import 'package:fimber_io/fimber_io.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/domain/location/use_case/get_current_location_use_case.dart';
import 'package:weather_app/domain/location/use_case/is_location_service_enabled_use_case.dart';
import 'package:weather_app/domain/location/use_case/request_location_permission_use_case.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_use_case.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_state.dart';
import 'package:weather_app/utils/l10n_model.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class HomeCubit extends SafetyCubit<HomeState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final GetSelectedLanguageCodeUseCase _getSelectedLanguageCodeUseCase;
  final IsLocationServiceEnabledUseCase _isLocationServiceEnabledUseCase;
  final CheckLocationPermissionStatusUseCase _checkLocationPermissionStatusUseCase;
  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;

  HomeCubit(
    this._getCurrentWeatherUseCase,
    this._getSelectedLanguageCodeUseCase,
    this._isLocationServiceEnabledUseCase,
    this._checkLocationPermissionStatusUseCase,
    this._requestLocationPermissionUseCase,
    this._getCurrentLocationUseCase,
  ) : super(const HomeState.idle());

  late String _selectedLangaugeCode;
  late CurrentWeather _currentWeather;

  Future<void> init({bool isRefreshPage = false}) async {
    try {
      isRefreshPage ? emit(HomeState.refreshPage(currentWeather: _currentWeather)) : emit(const HomeState.loading());

      final isLocationServiceEnabled = await _isLocationServiceEnabledUseCase();

      if (!isLocationServiceEnabled) {
        emit(const HomeState.locationDisabled());
        return;
      }

      final locationPermissionStatus = await _checkLocationPermissionStatusUseCase();

      if (locationPermissionStatus == LocationPermissionStatus.denied) {
        final newLocationPermissionStatus = await _requestLocationPermissionUseCase();

        if (newLocationPermissionStatus == LocationPermissionStatus.denied) {
          emit(const HomeState.locationPermissionDenied());
          return;
        }
      }

      if (locationPermissionStatus == LocationPermissionStatus.deniedForever) {
        emit(const HomeState.locationPermissionDenied());
        return;
      }

      final currentLocation = await _getCurrentLocationUseCase();

      _selectedLangaugeCode = _getSelectedLanguageCodeUseCase() ?? englishLanguageCode;

      _currentWeather = await _getCurrentWeatherUseCase(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        languageCode: _selectedLangaugeCode,
      );

      emit(HomeState.loaded(currentWeather: _currentWeather));
    } catch (error, st) {
      Fimber.e('Error while getting current weather', ex: error, stacktrace: st);
      emit(const HomeState.error());
    }
  }

  void goToSettings() {
    emit(const HomeState.idle());
    emit(const HomeState.goToSettings());
  }
}
