import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/router/router.dart';
import 'package:weather_app/weather_app.dart';

bool _firebaseCoreMocksInstalled = false;

extension Bootstrap on WidgetTester {
  /// Bootstraps the test environment by configuring dependencies and pumping the WeatherApp widget.
  Future<void> bootstrapWidgetTest({
    List<void Function()>? overrides,
    GoRouter? appRouter,
  }) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    if (!_firebaseCoreMocksInstalled) {
      setupFirebaseCoreMocks();
      _firebaseCoreMocksInstalled = true;
    }
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'test-api-key',
          appId: '1:000000000000:ios:0000000000000000test',
          messagingSenderId: '000000000000',
          projectId: 'test-project',
        ),
      );
    } on FirebaseException catch (exception) {
      if (exception.code != 'duplicate-app') {
        rethrow;
      }
    }
    await configureDependencies(Environment.test);
    if (overrides != null) {
      for (final void Function() override in overrides) {
        override();
      }
    }

    await pumpWidget(WeatherApp(appRouter: appRouter ?? router));
  }
}
