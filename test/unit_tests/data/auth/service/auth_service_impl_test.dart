import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/auth/data_source/auth_data_source.dart';
import 'package:weather_app/data/auth/service/auth_service_impl.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/auth_errors.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

import 'auth_service_impl_test.mocks.dart';

@GenerateMocks(<Type>[AuthDataSource, User])
void main() {
  late AuthDataSource authDataSource;
  late AuthService authService;

  setUp(() {
    authDataSource = MockAuthDataSource();
    authService = AuthServiceImpl(authDataSource);
  });

  group('AuthServiceImpl', () {
    const String email = 'a@b.com';
    const String password = 'secret';

    group('signInWithEmailAndPassword', () {
      test('returns AuthUser on success', () async {
        final User mockUser = MockUser();
        when(mockUser.uid).thenReturn('uid-1');
        when(mockUser.email).thenReturn(email);
        when(mockUser.emailVerified).thenReturn(true);
        when(
          authDataSource.signInWithEmailAndPassword(email: email, password: password),
        ).thenAnswer((_) async => mockUser);

        final Either<GenericError, AuthUser> result = await authService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        expect(result.isSuccess(), isTrue);
        expect(
          result.getOrElse(const AuthUser(uid: '', isEmailVerified: false)),
          equals(const AuthUser(uid: 'uid-1', isEmailVerified: true, email: email)),
        );
        verify(
          authDataSource.signInWithEmailAndPassword(email: email, password: password),
        ).called(1);
      });

      test('maps FirebaseAuthException to typed error', () async {
        when(
          authDataSource.signInWithEmailAndPassword(email: email, password: password),
        ).thenThrow(FirebaseAuthException(code: 'wrong-password', message: 'bad'));

        final Either<GenericError, AuthUser> result = await authService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        expect(result.isFailure(), isTrue);
        result.fold(
          (Object err) => expect(err, isA<AuthInvalidCredentialsError>()),
          (_) => fail('expected failure'),
        );
      });

      test('maps unknown errors to UnexpectedError', () async {
        when(
          authDataSource.signInWithEmailAndPassword(email: email, password: password),
        ).thenThrow(Exception());

        final Either<GenericError, AuthUser> result = await authService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        expect(result.isFailure(), isTrue);
        result.fold(
          (Object err) => expect(err, isA<UnexpectedError>()),
          (_) => fail('expected failure'),
        );
      });
    });

    group('registerWithEmailAndPassword', () {
      test('returns AuthUser on success', () async {
        final User mockUser = MockUser();
        when(mockUser.uid).thenReturn('uid-2');
        when(mockUser.email).thenReturn(email);
        when(mockUser.emailVerified).thenReturn(false);
        when(
          authDataSource.createUserWithEmailAndPassword(email: email, password: password),
        ).thenAnswer((_) async => mockUser);

        final Either<GenericError, AuthUser> result = await authService.registerWithEmailAndPassword(
          email: email,
          password: password,
        );

        expect(result.isSuccess(), isTrue);
        expect(
          result.getOrElse(const AuthUser(uid: '', isEmailVerified: true)),
          equals(const AuthUser(uid: 'uid-2', isEmailVerified: false, email: email)),
        );
      });
    });

    group('signOut', () {
      test('returns success when signOut completes', () async {
        when(authDataSource.signOut()).thenAnswer((_) async {});

        final Either<GenericError, void> result = await authService.signOut();

        expect(result.isSuccess(), isTrue);
        verify(authDataSource.signOut()).called(1);
      });
    });

    group('subscribeToAuthStateChanges', () {
      test('maps stream events to AuthUser', () async {
        final User mockUser = MockUser();
        when(mockUser.uid).thenReturn('u');
        when(mockUser.email).thenReturn(null);
        when(mockUser.emailVerified).thenReturn(false);
        when(authDataSource.authStateChanges).thenAnswer((_) => Stream<User?>.value(mockUser));

        final List<AuthUser?> emitted = <AuthUser?>[];
        final StreamSubscription<AuthUser?> subscription = authService.subscribeToAuthStateChanges().listen(
          emitted.add,
        );
        await Future<void>.delayed(Duration.zero);
        await subscription.cancel();

        expect(emitted, hasLength(1));
        expect(emitted.single, equals(const AuthUser(uid: 'u', isEmailVerified: false)));
      });
    });
  });
}
