import 'package:geolocator/geolocator.dart';

enum LocationPermissionStatus {
  denied,
  deniedForever,
  whileInUse,
  always,
  unableToDetermine,
}

extension LocationPermissionMapper on LocationPermission {
  LocationPermissionStatus toDomain() => switch (this) {
        LocationPermission.denied => LocationPermissionStatus.denied,
        LocationPermission.deniedForever => LocationPermissionStatus.deniedForever,
        LocationPermission.whileInUse => LocationPermissionStatus.whileInUse,
        LocationPermission.always => LocationPermissionStatus.always,
        LocationPermission.unableToDetermine => LocationPermissionStatus.unableToDetermine,
      };
}
