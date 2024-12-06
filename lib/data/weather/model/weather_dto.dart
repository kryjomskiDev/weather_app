import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/data/weather/model/weather_details_dto.dart';
import 'package:weather_app/data/weather/model/weather_temp_info_dto.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';

part 'weather_dto.g.dart';

@JsonSerializable(createToJson: false)
class WeatherDto {
  final String name;
  final List<WeatherDetailsDto> weather;
  final WeatherTempInfoDto main;

  const WeatherDto(
    this.name,
    this.weather,
    this.main,
  );

  factory WeatherDto.fromJson(Map<String, dynamic> json) => _$WeatherDtoFromJson(json);
}

extension WeatherDtoMapper on WeatherDto {
  CurrentWeather toDomain() => CurrentWeather(
        locationName: name,
        descritpion: weather.first.description,
        icon: weather.first.icon,
        temperature: main.temp,
        title: weather.first.main,
      );
}
