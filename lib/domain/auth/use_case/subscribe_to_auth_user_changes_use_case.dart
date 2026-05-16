import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';

@injectable
class SubscribeToAuthUserChangesUseCase {
  final AuthService _authService;

  const SubscribeToAuthUserChangesUseCase(this._authService);

  Stream<AuthUser?> call() => _authService.subscribeToAuthStateChanges();
}
