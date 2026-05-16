import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class RegisterWithEmailAndPasswordUseCase {
  final AuthService _authService;

  const RegisterWithEmailAndPasswordUseCase(this._authService);

  Future<Either<GenericError, AuthUser>> call({
    required String email,
    required String password,
  }) => _authService.registerWithEmailAndPassword(email: email, password: password);
}
