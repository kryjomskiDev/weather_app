import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

abstract interface class LocationService {
  Future<Either<GenericError, bool>> isLocationServiceEnabled();

  Future<Either<GenericError, LocationPermissionStatus>> checkLocationPermission();

  Future<Either<GenericError, LocationPermissionStatus>> requestLocationPermission();

  Future<Either<GenericError, CurrentLocation>> getCurrentLocation();
}
