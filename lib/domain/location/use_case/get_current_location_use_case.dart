import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/service/location_service.dart';

@injectable
class GetCurrentLocationUseCase {
  final LocationService _locationService;

  const GetCurrentLocationUseCase(this._locationService);

  Future<CurrentLocation> call() => _locationService.getCurrentLocation();
}
