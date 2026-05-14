import 'dart:async';

import 'package:fimber_io/fimber_io.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/config/get_environment.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/injectable/staging_environment.dart';
import 'package:weather_app/presentation/router/router.dart';
import 'package:weather_app/weather_app.dart';

const _supportedEnvironments = [Environment.prod, Environment.dev, StagingEnvironment.staging];

Future<void>? main() => runMobileApp(getEnvironment());

Future<void>? runMobileApp(final String environment) => runZonedGuarded<Future<void>>(() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    _errorHandler(details.exception, details.stack ?? StackTrace.current);
  };

  if (!_supportedEnvironments.contains(environment)) {
    throw ArgumentError('Environment $environment is not supported');
  }

  await configureDependencies(environment);

  runApp(WeatherApp(appRouter: router));
}, _errorHandler);

void _errorHandler(Object error, StackTrace stackTrace) {
  //You can redirect errors to one place and bring user to ErrorPage
  Fimber.e('Main error report.', ex: error, stacktrace: stackTrace);
}
