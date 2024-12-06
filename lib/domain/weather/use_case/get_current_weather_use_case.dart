import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';

@injectable
class GetCurrentWeatherUseCase {
  final WeatherService _weatherService;

  const GetCurrentWeatherUseCase(this._weatherService);

  Future<CurrentWeather> call({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) =>
      _weatherService.getCurrentWeather(
        latitude: latitude,
        longitude: longitude,
        languageCode: languageCode,
      );
}
