import 'package:dio/dio.dart';
import 'package:fimber_io/fimber_io.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/weather/data_source/weather_api_data_source.dart';
import 'package:weather_app/data/weather/model/weather_dto.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';
import 'package:weather_app/extensions/dio_error_extension.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/http_errors.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

@LazySingleton(as: WeatherService)
class WeatherServiceImpl implements WeatherService {
  final WeatherApiDataSource _weatherApiDataSource;

  const WeatherServiceImpl(this._weatherApiDataSource);

  @override
  Future<Either<GenericError, CurrentWeather>> getCurrentWeather({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    try {
      final WeatherDto dto = await _weatherApiDataSource.getWeatherByCords(latitude, longitude, languageCode);

      return Success<GenericError, CurrentWeather>(dto.toDomain());
    } on DioException catch (e, st) {
      final HttpError error = e.handleException;
      Fimber.e('Get current weather error', ex: e, stacktrace: st);
      return Failure<GenericError, CurrentWeather>(error);
    } catch (error, stackTrace) {
      Fimber.e('Get current weather error', ex: error, stacktrace: stackTrace);
      return const Failure<GenericError, CurrentWeather>(UnexpectedError(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<GenericError, CurrentWeather>> getCurrentWeatherByCity({
    required String city,
    required String languageCode,
  }) async {
    try {
      final WeatherDto dto = await _weatherApiDataSource.getWeatherByCity(city, languageCode);

      return Success<GenericError, CurrentWeather>(dto.toDomain());
    } on DioException catch (e, st) {
      final HttpError error = e.handleException;
      Fimber.e('Get current weather by city error', ex: e, stacktrace: st);
      return Failure<GenericError, CurrentWeather>(error);
    } catch (error, stackTrace) {
      Fimber.e('Get current weather by city error', ex: error, stacktrace: stackTrace);
      return const Failure<GenericError, CurrentWeather>(UnexpectedError(message: 'An unexpected error occurred'));
    }
  }
}
