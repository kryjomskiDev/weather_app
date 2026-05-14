import 'package:injectable/injectable.dart';
import 'package:weather_app/config/envs.dart';
import 'package:weather_app/injectable/staging_environment.dart';

@module
abstract class EnvsModule {
  @singleton
  @dev
  @staging
  @prod
  Envs get envs => const Envs();
}
