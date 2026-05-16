import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

@injectable
class SignOutUseCase {
  final AuthService _authService;

  const SignOutUseCase(this._authService);

  Future<Either<GenericError, void>> call() => _authService.signOut();
}
