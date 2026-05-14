import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/config/get_environment.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/router/router.dart';
import 'package:weather_app/weather_app.dart';

extension IntegrationTestBootstrap on WidgetTester {
  Future<void> bootstrapIntegrationTest({List<void Function()>? overrides}) async {
    await configureDependencies(getEnvironment());
    if (overrides != null) {
      for (final override in overrides) {
        override();
      }
    }

    await pumpWidget(WeatherApp(appRouter: router));
  }
}
