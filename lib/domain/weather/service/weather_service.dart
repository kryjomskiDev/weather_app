import 'package:weather_app/domain/weather/model/current_weather.dart';

abstract interface class WeatherService {
  Future<CurrentWeather> getCurrentWeather({
    required double latitude,
    required double longitude,
    required String languageCode,
  });
}
