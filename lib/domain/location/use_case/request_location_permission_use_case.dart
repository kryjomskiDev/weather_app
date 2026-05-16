import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class RequestLocationPermissionUseCase {
  final LocationService _locationService;

  const RequestLocationPermissionUseCase(this._locationService);

  Future<Either<GenericError, LocationPermissionStatus>> call() => _locationService.requestLocationPermission();
}
