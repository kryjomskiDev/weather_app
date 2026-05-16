import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/utils/error_handling/errors/auth_errors.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

extension FirebaseAuthExtension on FirebaseAuthException {
  GenericError get handleException => _mapFirebaseAuthException(this);
}

GenericError _mapFirebaseAuthException(FirebaseAuthException exception) => switch (exception.code) {
  'invalid-email' => AuthInvalidEmailError(message: exception.message),
  'wrong-password' ||
  'user-not-found' ||
  'invalid-credential' ||
  'account-exists-with-different-credential' => AuthInvalidCredentialsError(message: exception.message),
  'email-already-in-use' => AuthEmailAlreadyInUseError(message: exception.message),
  'weak-password' => AuthWeakPasswordError(message: exception.message),
  'user-token-expired' ||
  'invalid-user-token' ||
  'credential-invalidated' => AuthSessionExpiredError(message: exception.message),
  'user-disabled' => AuthUserDisabledError(message: exception.message),
  'network-request-failed' => AuthNetworkError(message: exception.message),
  'too-many-requests' => AuthTooManyRequestsError(message: exception.message),
  _ => UnexpectedError(message: exception.message ?? 'An unexpected error occurred'),
};
