import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/config/firebase/firebase_options_dev.dart' as firebase_dev;
import 'package:weather_app/config/firebase/firebase_options_production.dart' as firebase_production;
import 'package:weather_app/config/firebase/firebase_options_staging.dart' as firebase_staging;
import 'package:weather_app/injectable/staging_environment.dart';

FirebaseOptions resolveFirebaseOptions(String environment) {
  if (kIsWeb) {
    throw UnsupportedError('Firebase is not configured for web.');
  }
  switch (environment) {
    case Environment.prod:
      return firebase_production.DefaultFirebaseOptions.currentPlatform;
    case Environment.dev:
      return _firebaseOptionsDev();
    case StagingEnvironment.staging:
      return _firebaseOptionsStaging();
    default:
      throw ArgumentError('Unsupported environment for Firebase: $environment');
  }
}

FirebaseOptions _firebaseOptionsDev() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return firebase_dev.DefaultFirebaseOptions.android;
    case TargetPlatform.iOS:
      return firebase_production.DefaultFirebaseOptions.ios;
    default:
      throw UnsupportedError(
        'Firebase is only configured for Android and iOS (environment: dev).',
      );
  }
}

FirebaseOptions _firebaseOptionsStaging() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return firebase_staging.DefaultFirebaseOptions.android;
    case TargetPlatform.iOS:
      return firebase_production.DefaultFirebaseOptions.ios;
    default:
      throw UnsupportedError(
        'Firebase is only configured for Android and iOS (environment: staging).',
      );
  }
}
