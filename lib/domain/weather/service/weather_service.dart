import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

abstract interface class WeatherService {
  Future<Either<GenericError, CurrentWeather>> getCurrentWeather({
    required double latitude,
    required double longitude,
    required String languageCode,
  });

  Future<Either<GenericError, CurrentWeather>> getCurrentWeatherByCity({
    required String city,
    required String languageCode,
  });
}
