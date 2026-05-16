import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class GetCurrentWeatherByCityUseCase {
  final WeatherService _weatherService;

  const GetCurrentWeatherByCityUseCase(this._weatherService);

  Future<Either<GenericError, CurrentWeather>> call({
    required String city,
    required String languageCode,
  }) => _weatherService.getCurrentWeatherByCity(city: city, languageCode: languageCode);
}
