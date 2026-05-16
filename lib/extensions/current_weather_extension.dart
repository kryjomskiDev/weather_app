import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/style/number_formats.dart';

extension CurrentWeatherExtension on CurrentWeather {
  String get formattedTemperature => WeatherAppNumberFormats.temperature.format(temperature);

  String get iconPath => 'https://openweathermap.org/img/wn/$icon@2x.png';
}
