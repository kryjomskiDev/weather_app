import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/location/data_source/location_data_source.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  final LocationDataSource _locationDataSource;

  const LocationServiceImpl(this._locationDataSource);

  @override
  Future<Either<GenericError, LocationPermissionStatus>> checkLocationPermission() async {
    try {
      final LocationPermission dto = await _locationDataSource.checkLocationPermission();

      if (dto == LocationPermission.deniedForever) {
        return const Failure<GenericError, LocationPermissionStatus>(LocationPermissionDeniedForeverError());
      } else {
        return Success<GenericError, LocationPermissionStatus>(dto.toDomain());
      }
    } catch (_) {
      return const Failure<GenericError, LocationPermissionStatus>(
        PlatformError(message: 'An unexpected error occurred'),
      );
    }
  }

  @override
  Future<Either<GenericError, CurrentLocation>> getCurrentLocation() async {
    try {
      final Position dto = await _locationDataSource.getCurrentLocation();

      return Success<GenericError, CurrentLocation>(dto.toDomain());
    } catch (_) {
      return const Failure<GenericError, CurrentLocation>(PlatformError(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<GenericError, LocationPermissionStatus>> requestLocationPermission() async {
    try {
      final LocationPermission dto = await _locationDataSource.requestLocationPermission();

      if (dto == LocationPermission.deniedForever) {
        return const Failure<GenericError, LocationPermissionStatus>(LocationPermissionDeniedForeverError());
      } else {
        return Success<GenericError, LocationPermissionStatus>(dto.toDomain());
      }
    } catch (_) {
      return const Failure<GenericError, LocationPermissionStatus>(
        PlatformError(message: 'An unexpected error occurred'),
      );
    }
  }

  @override
  Future<Either<GenericError, bool>> isLocationServiceEnabled() async {
    try {
      final bool isEnabled = await _locationDataSource.isLocationServiceEnabled();

      if (isEnabled) {
        return Success<GenericError, bool>(isEnabled);
      } else {
        return const Failure<GenericError, bool>(LocationServiceDisabledError());
      }
    } catch (_) {
      return const Failure<GenericError, bool>(PlatformError(message: 'An unexpected error occurred'));
    }
  }
}
