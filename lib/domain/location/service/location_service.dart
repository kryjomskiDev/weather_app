import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';

abstract interface class LocationService {
  Future<bool> isLocationServiceEnabled();

  Future<LocationPermissionStatus> checkLocationPermission();

  Future<LocationPermissionStatus> requestLocationPermission();

  Future<CurrentLocation> getCurrentLocation();
}
