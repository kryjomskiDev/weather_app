import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class GetCurrentLocationUseCase {
  final LocationService _locationService;

  const GetCurrentLocationUseCase(this._locationService);

  Future<Either<GenericError, CurrentLocation>> call() => _locationService.getCurrentLocation();
}
