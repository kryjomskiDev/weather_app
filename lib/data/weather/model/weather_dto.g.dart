// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
      json['name'] as String,
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherDetailsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      WeatherTempInfoDto.fromJson(json['main'] as Map<String, dynamic>),
    );
