import 'dart:async';

import 'package:fimber_io/fimber_io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/config/firebase/firebase_options_resolver.dart';
import 'package:weather_app/config/get_environment.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/injectable/staging_environment.dart';
import 'package:weather_app/presentation/router/router.dart';
import 'package:weather_app/utils/error_handling/diagnostics_log_tree.dart';
import 'package:weather_app/weather_app.dart';

const List<String> _supportedEnvironments = <String>[
  Environment.prod,
  Environment.dev,
  StagingEnvironment.staging,
];

Future<void>? main() => runMobileApp(getEnvironment());

Future<void>? runMobileApp(final String environment) => runZonedGuarded<Future<void>>(
  () async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!_supportedEnvironments.contains(environment)) {
      throw ArgumentError('Environment $environment is not supported');
    }

    await Firebase.initializeApp(options: resolveFirebaseOptions(environment));

    Fimber.plantTree(DiagnosticsLogTree());
    if (kDebugMode) {
      Fimber.plantTree(DebugTree(useColors: true));
    }

    FlutterError.onError = (FlutterErrorDetails details) {
      _errorHandler(details.exception, details.stack ?? StackTrace.current);
    };

    await configureDependencies(environment);

    runApp(WeatherApp(appRouter: router));
  },
  (Object error, StackTrace stackTrace) {
    _errorHandler(error, stackTrace);
  },
);

void _errorHandler(Object error, StackTrace stackTrace) =>
    Fimber.e('Main error report.', ex: error, stacktrace: stackTrace);
