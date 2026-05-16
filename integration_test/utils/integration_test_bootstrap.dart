import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/config/get_environment.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/presentation/router/router.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';
import 'package:weather_app/weather_app.dart';

bool _firebaseCoreMocksInstalled = false;

extension IntegrationTestBootstrap on WidgetTester {
  Future<void> bootstrapIntegrationTest({List<void Function()>? overrides}) async {
    TestWidgetsFlutterBinding.ensureInitialized();
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

    await getIt.reset();
    await configureDependencies(getEnvironment());
    if (overrides != null) {
      for (final void Function() override in overrides) {
        override();
      }
    }

    router.go(WeatherAppRoutes.splash.path);
    await pumpWidget(WeatherApp(appRouter: router));
  }
}
