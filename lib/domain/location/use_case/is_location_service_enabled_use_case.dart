import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class IsLocationServiceEnabledUseCase {
  final LocationService _locationService;

  const IsLocationServiceEnabledUseCase(this._locationService);

  Future<Either<GenericError, bool>> call() => _locationService.isLocationServiceEnabled();
}
