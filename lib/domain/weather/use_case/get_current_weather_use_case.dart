import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class GetCurrentWeatherUseCase {
  final WeatherService _weatherService;

  const GetCurrentWeatherUseCase(this._weatherService);

  Future<Either<GenericError, CurrentWeather>> call({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) => _weatherService.getCurrentWeather(latitude: latitude, longitude: longitude, languageCode: languageCode);
}
