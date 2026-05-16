import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/subscribe_to_auth_user_changes_use_case.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_presentation_event.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_state.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class MainShellSessionCubit extends SafetyCubit<MainSessionState>
    with BlocPresentationMixin<MainSessionState, MainSessionPresentationEvent> {
  MainShellSessionCubit(this._subscribeToAuthUserChangesUseCase) : super(const MainSessionStateLoaded());

  final SubscribeToAuthUserChangesUseCase _subscribeToAuthUserChangesUseCase;

  StreamSubscription<String?>? _uidSubscription;

  void start() {
    if (_uidSubscription != null) {
      return;
    }
    bool receivedFirstEvent = false;
    String? previousUid;
    _uidSubscription = _subscribeToAuthUserChangesUseCase()
        .map((AuthUser? user) => user?.uid)
        .distinct()
        .listen((String? uid) {
      if (uid == null) {
        final bool wasSignedIn = previousUid != null;
        final bool firstEventWithoutUser = !receivedFirstEvent;
        if (wasSignedIn || firstEventWithoutUser) {
          emitPresentation(const MainSessionExpiredEvent());
        }
      }
      receivedFirstEvent = true;
      previousUid = uid;
    });
  }

  @override
  Future<void> close() async {
    await _uidSubscription?.cancel();
    await super.close();
  }
}
