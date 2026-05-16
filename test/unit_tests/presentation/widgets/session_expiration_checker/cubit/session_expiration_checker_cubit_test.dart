import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/subscribe_to_auth_user_changes_use_case.dart';
import 'package:weather_app/presentation/widgets/session_expiration_checker/cubit/session_expiration_checker_cubit.dart';
import 'package:weather_app/presentation/widgets/session_expiration_checker/cubit/session_expiration_checker_state.dart';

import 'session_expiration_checker_cubit_test.mocks.dart';

@GenerateMocks(<Type>[SubscribeToAuthUserChangesUseCase])
void main() {
  late SubscribeToAuthUserChangesUseCase subscribeToAuthUserChangesUseCase;
  late StreamController<AuthUser?> userController;

  setUp(() {
    subscribeToAuthUserChangesUseCase = MockSubscribeToAuthUserChangesUseCase();
    userController = StreamController<AuthUser?>.broadcast();
    when(subscribeToAuthUserChangesUseCase()).thenAnswer((_) => userController.stream);
  });

  tearDown(() async {
    await userController.close();
  });

  group('SessionExpirationCheckerCubit', () {
    test('emits unauthenticated when user is null', () async {
      final SessionExpirationCheckerCubit cubit = SessionExpirationCheckerCubit(subscribeToAuthUserChangesUseCase);
      final List<SessionExpirationCheckerState> states = <SessionExpirationCheckerState>[];
      final StreamSubscription<SessionExpirationCheckerState> subscription = cubit.stream.listen(states.add);

      await cubit.init();
      userController.add(null);
      await Future<void>.delayed(Duration.zero);

      expect(
        states,
        contains(const SessionExpirationCheckerUnauthenticatedState()),
      );

      await subscription.cancel();
      await cubit.close();
    });

    test('emits authenticated when user is signed in', () async {
      final SessionExpirationCheckerCubit cubit = SessionExpirationCheckerCubit(subscribeToAuthUserChangesUseCase);
      final List<SessionExpirationCheckerState> states = <SessionExpirationCheckerState>[];
      final StreamSubscription<SessionExpirationCheckerState> subscription = cubit.stream.listen(states.add);

      await cubit.init();
      const AuthUser user = AuthUser(uid: 'uid1', isEmailVerified: true);
      userController.add(user);
      await Future<void>.delayed(Duration.zero);

      expect(
        states,
        contains(const SessionExpirationCheckerAuthenticatedState()),
      );

      await subscription.cancel();
      await cubit.close();
    });

    test('emits unauthenticated when user goes from signed in to signed out', () async {
      final SessionExpirationCheckerCubit cubit = SessionExpirationCheckerCubit(subscribeToAuthUserChangesUseCase);
      final List<SessionExpirationCheckerState> states = <SessionExpirationCheckerState>[];
      final StreamSubscription<SessionExpirationCheckerState> subscription = cubit.stream.listen(states.add);

      await cubit.init();
      const AuthUser user = AuthUser(uid: 'uid1', isEmailVerified: true);
      userController.add(user);
      await Future<void>.delayed(Duration.zero);
      userController.add(null);
      await Future<void>.delayed(Duration.zero);

      expect(states.last, const SessionExpirationCheckerUnauthenticatedState());

      await subscription.cancel();
      await cubit.close();
    });

    test('does not emit authenticated again when same user is emitted again', () async {
      final SessionExpirationCheckerCubit cubit = SessionExpirationCheckerCubit(subscribeToAuthUserChangesUseCase);
      final List<SessionExpirationCheckerState> states = <SessionExpirationCheckerState>[];
      final StreamSubscription<SessionExpirationCheckerState> subscription = cubit.stream.listen(states.add);

      await cubit.init();
      const AuthUser user = AuthUser(uid: 'uid1', isEmailVerified: true);
      userController.add(user);
      await Future<void>.delayed(Duration.zero);
      userController.add(user);
      await Future<void>.delayed(Duration.zero);

      expect(
        states.whereType<SessionExpirationCheckerAuthenticatedState>().length,
        1,
      );

      await subscription.cancel();
      await cubit.close();
    });
  });
}
