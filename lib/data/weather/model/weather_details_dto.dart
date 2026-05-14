import 'package:json_annotation/json_annotation.dart';

part 'weather_details_dto.g.dart';

@JsonSerializable(createToJson: false)
class WeatherDetailsDto {
  final String main;
  final String description;
  final String icon;

  const WeatherDetailsDto(
    this.main,
    this.description,
    this.icon,
  );

  factory WeatherDetailsDto.fromJson(Map<String, dynamic> json) => _$WeatherDetailsDtoFromJson(json);
}
