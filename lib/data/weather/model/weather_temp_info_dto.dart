import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_temp_info_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class WeatherTempInfoDto {
  final double temp;

  const WeatherTempInfoDto(
    this.temp,
  );

  factory WeatherTempInfoDto.fromJson(Map<String, dynamic> json) => _$WeatherTempInfoDtoFromJson(json);
}
