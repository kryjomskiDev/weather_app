import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

/// Error that occurs when a platform-specific operation fails.
class PlatformError extends GenericError {
  final String? message;

  const PlatformError({this.message});
}

class UnexpectedError extends GenericError {
  final String? message;

  const UnexpectedError({this.message});
}

class LocationServiceDisabledError extends GenericError {
  const LocationServiceDisabledError();
}

class LocationPermissionDeniedForeverError extends GenericError {
  const LocationPermissionDeniedForeverError();
}
