import 'package:fimber_io/fimber_io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/auth/data_source/auth_data_source.dart';
import 'package:weather_app/data/auth/mapper/firebase_user_mapper.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';
import 'package:weather_app/extensions/firebase_auth_error_extension.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  final AuthDataSource _authDataSource;

  const AuthServiceImpl(this._authDataSource);

  @override
  AuthUser? getCurrentAuthUser() => _authDataSource.currentUser?.toAuthUser();

  @override
  Future<Either<GenericError, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final User user = await _authDataSource.signInWithEmailAndPassword(email: email, password: password);

      return Success<GenericError, AuthUser>(user.toAuthUser());
    } on FirebaseAuthException catch (e, st) {
      Fimber.e('Sign in with email and password error', ex: e, stacktrace: st);
      return Failure<GenericError, AuthUser>(e.handleException);
    } catch (error, stackTrace) {
      Fimber.e('Sign in with email and password error', ex: error, stacktrace: stackTrace);
      return const Failure<GenericError, AuthUser>(UnexpectedError(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<GenericError, AuthUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final User user = await _authDataSource.createUserWithEmailAndPassword(email: email, password: password);

      return Success<GenericError, AuthUser>(user.toAuthUser());
    } on FirebaseAuthException catch (e, st) {
      Fimber.e('Register with email and password error', ex: e, stacktrace: st);
      return Failure<GenericError, AuthUser>(e.handleException);
    } catch (error, stackTrace) {
      Fimber.e('Register with email and password error', ex: error, stacktrace: stackTrace);
      return const Failure<GenericError, AuthUser>(UnexpectedError(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<GenericError, void>> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Success<GenericError, void>(null);
    } on FirebaseAuthException catch (e, st) {
      Fimber.e('Sign out error', ex: e, stacktrace: st);
      return Failure<GenericError, void>(e.handleException);
    } catch (error, stackTrace) {
      Fimber.e('Sign out error', ex: error, stacktrace: stackTrace);
      return const Failure<GenericError, void>(
        UnexpectedError(message: 'An unexpected error occurred'),
      );
    }
  }

  @override
  Stream<AuthUser?> subscribeToAuthStateChanges() => _authDataSource.authStateChanges.map(
    (User? user) => user?.toAuthUser(),
  );
}
