import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';

@injectable
class GetCurrentAuthUserUseCase {
  final AuthService _authService;

  const GetCurrentAuthUserUseCase(this._authService);

  AuthUser? call() => _authService.getCurrentAuthUser();
}
