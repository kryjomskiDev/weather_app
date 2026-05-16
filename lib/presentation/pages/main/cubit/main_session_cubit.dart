import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/subscribe_to_auth_user_changes_use_case.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_presentation_event.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_state.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class MainSessionCubit extends SafetyCubit<MainSessionState>
    with BlocPresentationMixin<MainSessionState, MainSessionPresentationEvent> {
  final SubscribeToAuthUserChangesUseCase _subscribeToAuthUserChangesUseCase;

  MainSessionCubit(this._subscribeToAuthUserChangesUseCase) : super(const MainSessionStateLoading());

  StreamSubscription<AuthUser?>? _authUserSubscription;

  Future<void> init() async {
    emit(const MainSessionStateLoading());
    await _authUserSubscription?.cancel();
    _authUserSubscription = _subscribeToAuthUserChangesUseCase().listen((AuthUser? user) {
      if (user == null) {
        emitPresentation(const MainSessionExpiredEvent());
      }
    });
    emit(const MainSessionStateLoaded());
  }

  @override
  Future<void> close() async {
    await _authUserSubscription?.cancel();
    await super.close();
  }
}
