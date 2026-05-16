import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/data/weather/model/weather_dto.dart';
import 'package:weather_app/networking_config/endpoints.dart';
import 'package:weather_app/networking_config/query.dart';

part 'weather_api_data_source.g.dart';

@injectable
@RestApi()
abstract class WeatherApiDataSource {
  @factoryMethod
  factory WeatherApiDataSource(Dio dio) = _WeatherApiDataSource;

  @GET(WeatherAppEndpoints.currentWeather)
  Future<WeatherDto> getWeatherByCords(
    @Query(WeatherAppQuery.latitude) double latitude,
    @Query(WeatherAppQuery.longitude) double longitude,
    @Query(WeatherAppQuery.language) String lang, [
    @Query(WeatherAppQuery.units) String units = WeatherAppQuery.metric,
  ]);
}
