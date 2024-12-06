import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/service/location_service.dart';

@injectable
class IsLocationServiceEnabledUseCase {
  final LocationService _locationService;

  const IsLocationServiceEnabledUseCase(this._locationService);

  Future<bool> call() => _locationService.isLocationServiceEnabled();
}
