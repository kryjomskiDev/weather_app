import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/data/weather/model/weather_dto.dart';
import 'package:weather_app/networking_config/endpoints.dart';
import 'package:weather_app/networking_config/query.dart' as query;

part 'weather_api_data_source.g.dart';

@injectable
@RestApi()
abstract class WeatherApiDataSource {
  @factoryMethod
  factory WeatherApiDataSource(Dio dio) = _WeatherApiDataSource;

  @GET(currentWeather)
  Future<WeatherDto> getWeatherByCords(
    @Query(query.latitude) double latitude,
    @Query(query.longitude) double longitude,
    @Query(query.language) String lang, [
    @Query(query.units) String units = query.metric,
  ]);
}
