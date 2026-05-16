import 'package:geolocator/geolocator.dart';

enum LocationPermissionStatus { granted, denied }

extension LocationPermissionMapper on LocationPermission {
  LocationPermissionStatus toDomain() => switch (this) {
    LocationPermission.denied => LocationPermissionStatus.denied,
    _ => LocationPermissionStatus.granted,
  };
}
