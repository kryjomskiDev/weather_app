import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/sign_in_with_email_and_password_use_case.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_cubit.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_presentation_event.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/auth_errors.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks(<Type>[SignInWithEmailAndPasswordUseCase])
void main() {
  late MockSignInWithEmailAndPasswordUseCase signInUseCase;

  const String email = 'user@example.com';
  const String password = 'password';
  const AuthUser authUser = AuthUser(
    uid: 'uid-1',
    email: email,
    isEmailVerified: true,
  );

  setUp(() {
    signInUseCase = MockSignInWithEmailAndPasswordUseCase();
  });

  LoginCubit buildCubit() => LoginCubit(signInUseCase);

  group('LoginCubit', () {
    test('has initial loaded state', () => expect(buildCubit().state, const LoginStateLoaded()));

    blocTest<LoginCubit, LoginState>(
      'emits [submitting, loaded] on successful sign in',
      setUp: () {
        when(
          signInUseCase(email: email, password: password),
        ).thenAnswer((_) async => Either.success(authUser));
      },
      build: buildCubit,
      act: (LoginCubit cubit) => cubit.signIn(email: email, password: password),
      expect: () => <LoginState>[
        const LoginStateSubmitting(),
        const LoginStateLoaded(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [submitting, loaded] on failed sign in',
      setUp: () {
        when(
          signInUseCase(email: email, password: password),
        ).thenAnswer(
          (_) async => Either.failure(
            const AuthInvalidCredentialsError(message: 'Invalid credentials'),
          ),
        );
      },
      build: buildCubit,
      act: (LoginCubit cubit) => cubit.signIn(email: email, password: password),
      expect: () => <LoginState>[
        const LoginStateSubmitting(),
        const LoginStateLoaded(),
      ],
    );

    test('does not emit presentation events on success', () async {
      when(
        signInUseCase(email: email, password: password),
      ).thenAnswer((_) async => Either.success(authUser));

      final LoginCubit cubit = buildCubit();
      final List<LoginPresentationEvent> events = <LoginPresentationEvent>[];
      final StreamSubscription<LoginPresentationEvent> sub = cubit.presentation.listen(events.add);

      await cubit.signIn(email: email, password: password);
      await pumpEventQueue();

      expect(events, isEmpty);
      await sub.cancel();
      await cubit.close();
    });

    test('emits LoginShowAuthErrorSnackBarEvent on failure', () async {
      when(
        signInUseCase(email: email, password: password),
      ).thenAnswer(
        (_) async => Either.failure(
          const AuthInvalidCredentialsError(message: 'Invalid credentials'),
        ),
      );

      final LoginCubit cubit = buildCubit();
      final List<LoginPresentationEvent> events = <LoginPresentationEvent>[];
      final StreamSubscription<LoginPresentationEvent> sub = cubit.presentation.listen(events.add);

      await cubit.signIn(email: email, password: password);
      await pumpEventQueue();

      expect(events, contains(const LoginShowAuthErrorSnackBarEvent()));
      await sub.cancel();
      await cubit.close();
    });
  });
}
