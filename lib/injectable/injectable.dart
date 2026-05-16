import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/injectable/dio_injectable/dio_injectable.dart';
import 'package:weather_app/injectable/injectable.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies(String environment) async {
  await $initGetIt(getIt, environment: environment);
  if (environment != Environment.test) registerInterceptors();
}

void registerOverride<T extends Object>(T Function() createMock) {
  if (getIt.isRegistered<T>()) getIt.unregister<T>();
  getIt.registerLazySingleton<T>(() => createMock());
}
