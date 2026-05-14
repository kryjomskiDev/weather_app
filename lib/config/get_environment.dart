import 'package:injectable/injectable.dart';

const String _environmentDefineKey = 'ENVIRONMENT';
const String prodEnvironmentName = 'production';

String getEnvironment() {
  const String baseEnvironment = String.fromEnvironment(_environmentDefineKey, defaultValue: Environment.prod);
  return baseEnvironment == prodEnvironmentName ? Environment.prod : baseEnvironment;
}
