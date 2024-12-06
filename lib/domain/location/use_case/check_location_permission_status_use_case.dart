import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';

@injectable
class CheckLocationPermissionStatusUseCase {
  final LocationService _locationService;

  const CheckLocationPermissionStatusUseCase(this._locationService);

  Future<LocationPermissionStatus> call() => _locationService.checkLocationPermission();
}
