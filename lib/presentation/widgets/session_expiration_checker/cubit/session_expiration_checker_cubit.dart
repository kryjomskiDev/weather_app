import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/subscribe_to_auth_user_changes_use_case.dart';
import 'package:weather_app/presentation/widgets/session_expiration_checker/cubit/session_expiration_checker_state.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class SessionExpirationCheckerCubit extends SafetyCubit<SessionExpirationCheckerState> {
  final SubscribeToAuthUserChangesUseCase _subscribeToAuthUserChangesUseCase;

  SessionExpirationCheckerCubit(
    this._subscribeToAuthUserChangesUseCase,
  ) : super(const SessionExpirationCheckerIdleState());

  StreamSubscription<AuthUser?>? _authUserSubscription;

  Future<void> init() async {
    await _authUserSubscription?.cancel();
    _authUserSubscription = _subscribeToAuthUserChangesUseCase().listen(_listener);
  }

  void _listener(AuthUser? user) {
    if (user == null) {
      emit(const SessionExpirationCheckerUnauthenticatedState());
    } else {
      emit(const SessionExpirationCheckerAuthenticatedState());
    }
  }

  @override
  Future<void> close() async {
    await _authUserSubscription?.cancel();
    await super.close();
  }
}
