import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/extensions/either_extensions.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class CheckLocationPermissionStatusUseCase {
  final LocationService _locationService;

  const CheckLocationPermissionStatusUseCase(this._locationService);

  Future<Either<GenericError, LocationPermissionStatus>> call() async {
    final Either<GenericError, LocationPermissionStatus> result = await _locationService.checkLocationPermission();

    if (result.isFailure()) {
      return result;
    }

    final Either<GenericError, LocationPermissionStatus> permissionStatusResult = await _locationService
        .checkLocationPermission();

    if (permissionStatusResult.isFailure()) {
      return permissionStatusResult;
    }

    final LocationPermissionStatus? permissionStatus = permissionStatusResult.extractValueOrNull();

    if (permissionStatus == LocationPermissionStatus.denied || permissionStatus == null) {
      final Either<GenericError, LocationPermissionStatus> newPermissionStatusResult = await _locationService
          .requestLocationPermission();

      return newPermissionStatusResult;
    } else {
      return permissionStatusResult;
    }
  }
}
