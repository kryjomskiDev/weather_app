import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

abstract interface class AuthService {
  AuthUser? getCurrentAuthUser();

  Future<Either<GenericError, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<GenericError, AuthUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<GenericError, void>> signOut();

  Stream<AuthUser?> subscribeToAuthStateChanges();
}
