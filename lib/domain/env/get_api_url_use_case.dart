import 'package:weather_app/injectable/staging_environment.dart';
import 'package:injectable/injectable.dart';

const String _devApiUrl = 'https://api.openweathermap.org/data/2.5/';
const String _stagingApiUrl = 'https://api.openweathermap.org/data/2.5/';
const String _prodApiUrl = 'https://api.openweathermap.org/data/2.5/';

abstract class GetApiUrlUseCase {
  String getApiUrl();
}

@dev
@Injectable(as: GetApiUrlUseCase)
class DevGetApiUrlUseCase implements GetApiUrlUseCase {
  @override
  String getApiUrl() => _devApiUrl;
}

@staging
@Injectable(as: GetApiUrlUseCase)
class StagingGetApiUrlUseCase implements GetApiUrlUseCase {
  @override
  String getApiUrl() => _stagingApiUrl;
}

@prod
@Injectable(as: GetApiUrlUseCase)
class ProdGetApiUrlUseCase implements GetApiUrlUseCase {
  @override
  String getApiUrl() => _prodApiUrl;
}
