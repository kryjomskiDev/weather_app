import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/register_with_email_and_password_use_case.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_cubit.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_presentation_event.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/auth_errors.dart';

import 'register_cubit_test.mocks.dart';

@GenerateMocks(<Type>[RegisterWithEmailAndPasswordUseCase])
void main() {
  late MockRegisterWithEmailAndPasswordUseCase registerUseCase;

  const String email = 'user@example.com';
  const String password = 'password';
  const AuthUser authUser = AuthUser(
    uid: 'uid-1',
    email: email,
    isEmailVerified: false,
  );

  setUp(() {
    registerUseCase = MockRegisterWithEmailAndPasswordUseCase();
  });

  RegisterCubit buildCubit() => RegisterCubit(registerUseCase);

  group('RegisterCubit', () {
    test('has initial loaded state', () => expect(buildCubit().state, const RegisterStateLoaded()));

    blocTest<RegisterCubit, RegisterState>(
      'emits [submitting, loaded] on successful register',
      setUp: () {
        when(
          registerUseCase(email: email, password: password),
        ).thenAnswer((_) async => Either.success(authUser));
      },
      build: buildCubit,
      act: (RegisterCubit cubit) => cubit.register(email: email, password: password),
      expect: () => <RegisterState>[
        const RegisterStateSubmitting(),
        const RegisterStateLoaded(),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [submitting, loaded] on failed register',
      setUp: () {
        when(
          registerUseCase(email: email, password: password),
        ).thenAnswer(
          (_) async => Either.failure(
            const AuthInvalidCredentialsError(message: 'Email already in use'),
          ),
        );
      },
      build: buildCubit,
      act: (RegisterCubit cubit) => cubit.register(email: email, password: password),
      expect: () => <RegisterState>[
        const RegisterStateSubmitting(),
        const RegisterStateLoaded(),
      ],
    );

    test('emits RegisterNavigateHomeEvent on success', () async {
      when(
        registerUseCase(email: email, password: password),
      ).thenAnswer((_) async => Either.success(authUser));

      final RegisterCubit cubit = buildCubit();
      final List<RegisterPresentationEvent> events = <RegisterPresentationEvent>[];
      final StreamSubscription<RegisterPresentationEvent> sub = cubit.presentation.listen(events.add);

      await cubit.register(email: email, password: password);
      await pumpEventQueue();

      expect(events, contains(const RegisterNavigateHomeEvent()));
      await sub.cancel();
      await cubit.close();
    });

    test('emits RegisterShowAuthErrorSnackBarEvent on failure', () async {
      when(
        registerUseCase(email: email, password: password),
      ).thenAnswer(
        (_) async => Either.failure(
          const AuthInvalidCredentialsError(message: 'Email already in use'),
        ),
      );

      final RegisterCubit cubit = buildCubit();
      final List<RegisterPresentationEvent> events = <RegisterPresentationEvent>[];
      final StreamSubscription<RegisterPresentationEvent> sub = cubit.presentation.listen(events.add);

      await cubit.register(email: email, password: password);
      await pumpEventQueue();

      expect(events, contains(const RegisterShowAuthErrorSnackBarEvent()));
      await sub.cancel();
      await cubit.close();
    });
  });
}
