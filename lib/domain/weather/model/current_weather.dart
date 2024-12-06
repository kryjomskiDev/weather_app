import 'package:equatable/equatable.dart';

class CurrentWeather extends Equatable {
  final String title;
  final String descritpion;
  final double temperature;
  final String icon;
  final String locationName;

  const CurrentWeather({
    required this.title,
    required this.descritpion,
    required this.temperature,
    required this.icon,
    required this.locationName,
  });

  @override
  List<Object?> get props => [
        title,
        descritpion,
        temperature,
        icon,
        locationName,
      ];
}
