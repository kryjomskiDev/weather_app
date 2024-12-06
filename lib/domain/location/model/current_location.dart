import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends Equatable {
  final double latitude;
  final double longitude;

  const CurrentLocation({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}

extension CurrentLocationMapper on Position {
  CurrentLocation toDomain() => CurrentLocation(
        latitude: latitude,
        longitude: longitude,
      );
}
