import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

/// Minimal [AuthService] for integration tests — always unsigned in.
class FakeAuthService implements AuthService {
  @override
  AuthUser? getCurrentAuthUser() => null;

  @override
  Stream<AuthUser?> subscribeToAuthStateChanges() => const Stream<AuthUser?>.empty();

  @override
  Future<Either<GenericError, AuthUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      const Failure<GenericError, AuthUser>(UnexpectedError());

  @override
  Future<Either<GenericError, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      const Failure<GenericError, AuthUser>(UnexpectedError());

  @override
  Future<Either<GenericError, void>> signOut() async => const Success<GenericError, void>(null);
}
