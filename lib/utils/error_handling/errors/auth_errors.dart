import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

/// Email or password does not match a user (sign-in).
class AuthInvalidCredentialsError extends GenericError {
  final String? message;

  const AuthInvalidCredentialsError({this.message});
}

/// Malformed email address.
class AuthInvalidEmailError extends GenericError {
  final String? message;

  const AuthInvalidEmailError({this.message});
}

/// Registration attempted with an email that is already registered.
class AuthEmailAlreadyInUseError extends GenericError {
  final String? message;

  const AuthEmailAlreadyInUseError({this.message});
}

/// Password does not meet Firebase strength rules.
class AuthWeakPasswordError extends GenericError {
  final String? message;

  const AuthWeakPasswordError({this.message});
}

/// ID token expired, revoked, or otherwise invalid; refresh failed.
class AuthSessionExpiredError extends GenericError {
  final String? message;

  const AuthSessionExpiredError({this.message});
}

/// User account has been disabled.
class AuthUserDisabledError extends GenericError {
  final String? message;

  const AuthUserDisabledError({this.message});
}

/// No signed-in user when one was required (e.g. session refresh).
class AuthNoSignedInUserError extends GenericError {
  final String? message;

  const AuthNoSignedInUserError({this.message});
}

/// Too many attempts; try again later.
class AuthTooManyRequestsError extends GenericError {
  final String? message;

  const AuthTooManyRequestsError({this.message});
}

/// Network error while calling Firebase Auth.
class AuthNetworkError extends GenericError {
  final String? message;

  const AuthNetworkError({this.message});
}
