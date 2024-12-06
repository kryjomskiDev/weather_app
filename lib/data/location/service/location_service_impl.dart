import 'package:injectable/injectable.dart';
import 'package:weather_app/data/location/data_source/location_data_source.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  final LocationDataSource _locationDataSource;

  const LocationServiceImpl(this._locationDataSource);

  @override
  Future<LocationPermissionStatus> checkLocationPermission() async {
    final dto = await _locationDataSource.checkLocationPermission();

    return dto.toDomain();
  }

  @override
  Future<CurrentLocation> getCurrentLocation() async {
    final dto = await _locationDataSource.getCurrentLocation();

    return dto.toDomain();
  }

  @override
  Future<LocationPermissionStatus> requestLocationPermission() async {
    final dto = await _locationDataSource.requestLocationPermission();

    return dto.toDomain();
  }

  @override
  Future<bool> isLocationServiceEnabled() => _locationDataSource.isLocationServiceEnabled();
}
