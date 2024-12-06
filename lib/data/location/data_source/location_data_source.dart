import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocationDataSource {
  Future<Position> getCurrentLocation() => Geolocator.getCurrentPosition();

  Future<bool> isLocationServiceEnabled() => Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> checkLocationPermission() => Geolocator.checkPermission();

  Future<LocationPermission> requestLocationPermission() => Geolocator.requestPermission();
}
