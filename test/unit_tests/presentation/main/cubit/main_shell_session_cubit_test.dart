import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/subscribe_to_auth_user_changes_use_case.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_presentation_event.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_shell_session_cubit.dart';

import 'main_shell_session_cubit_test.mocks.dart';

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

  group('MainShellSessionCubit', () {
    test('emits session lost when distinct uid goes from signed in to signed out', () async {
      final MainShellSessionCubit cubit = MainShellSessionCubit(subscribeToAuthUserChangesUseCase);
      final List<MainSessionPresentationEvent> presentationEvents = <MainSessionPresentationEvent>[];
      final StreamSubscription<MainSessionPresentationEvent> subscription = cubit.presentation.listen(
        presentationEvents.add,
      );

      cubit.start();
      const AuthUser user = AuthUser(uid: 'uid1', isEmailVerified: true);
      userController.add(user);
      await Future<void>.delayed(Duration.zero);
      userController.add(null);
      await Future<void>.delayed(Duration.zero);

      expect(
        presentationEvents,
        contains(const MainSessionExpiredEvent()),
      );

      await subscription.cancel();
      await cubit.close();
    });

    test('does not emit session lost when same uid is emitted again', () async {
      final MainShellSessionCubit cubit = MainShellSessionCubit(subscribeToAuthUserChangesUseCase);
      final List<MainSessionPresentationEvent> presentationEvents = <MainSessionPresentationEvent>[];
      final StreamSubscription<MainSessionPresentationEvent> subscription = cubit.presentation.listen(
        presentationEvents.add,
      );

      cubit.start();
      const AuthUser user = AuthUser(uid: 'uid1', isEmailVerified: true);
      userController.add(user);
      await Future<void>.delayed(Duration.zero);
      userController.add(user);
      await Future<void>.delayed(Duration.zero);

      expect(presentationEvents, isEmpty);

      await subscription.cancel();
      await cubit.close();
    });

    test('emits session lost on first emission when user is null', () async {
      final MainShellSessionCubit cubit = MainShellSessionCubit(subscribeToAuthUserChangesUseCase);
      final List<MainSessionPresentationEvent> presentationEvents = <MainSessionPresentationEvent>[];
      final StreamSubscription<MainSessionPresentationEvent> subscription = cubit.presentation.listen(
        presentationEvents.add,
      );

      cubit.start();
      userController.add(null);
      await Future<void>.delayed(Duration.zero);

      expect(
        presentationEvents,
        equals(<MainSessionPresentationEvent>[const MainSessionExpiredEvent()]),
      );

      await subscription.cancel();
      await cubit.close();
    });
  });
}
