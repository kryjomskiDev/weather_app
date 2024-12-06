import 'package:injectable/injectable.dart';
import 'package:weather_app/data/weather/data_source/weather_api_data_source.dart';
import 'package:weather_app/data/weather/model/weather_dto.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';

@LazySingleton(as: WeatherService)
class WeatherServiceImpl implements WeatherService {
  final WeatherApiDataSource _weatherApiDataSource;

  const WeatherServiceImpl(this._weatherApiDataSource);

  @override
  Future<CurrentWeather> getCurrentWeather({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    final dto = await _weatherApiDataSource.getWeatherByCords(
      latitude,
      longitude,
      languageCode,
    );

    return dto.toDomain();
  }
}
