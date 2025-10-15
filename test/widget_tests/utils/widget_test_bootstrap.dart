import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/router/router.dart';
import 'package:weather_app/weather_app.dart';

extension Bootstrap on WidgetTester {
  /// Bootstraps the test environment by configuring dependencies and pumping the WeatherApp widget.
  Future<void> bootstrapWidgetTest({
    List<void Function()>? overrides,
    GoRouter? appRouter,
  }) async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies(Environment.test);
    if (overrides != null) {
      for (final override in overrides) {
        override();
      }
    }

    await pumpWidget(WeatherApp(appRouter: appRouter ?? router));
  }
}
