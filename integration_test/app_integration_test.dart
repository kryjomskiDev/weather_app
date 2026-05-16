import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/domain/auth/service/auth_service.dart';
import 'package:weather_app/injectable/injectable.dart';

import 'utils/fake_auth_service.dart';
import 'utils/integration_test_bootstrap.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> bootstrapSignedOutApp(WidgetTester tester) => tester.bootstrapIntegrationTest(
    overrides: <void Function()>[
      () => registerOverride<AuthService>(FakeAuthService.new),
    ],
  );

  group('App integration test examples', () {
    testWidgets('shows splash welcome screen when user is not signed in', (WidgetTester tester) async {
      await bootstrapSignedOutApp(tester);
      await tester.pumpAndSettle();

      expect(find.text('Welcome!'), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text('Don\'t have an account? Sign up'), findsOneWidget);
    });

    testWidgets('opens login screen when Sign in is tapped on splash', (WidgetTester tester) async {
      await bootstrapSignedOutApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sign in'));
      await tester.pumpAndSettle();

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Log in'), findsAtLeastNWidgets(1));
    });

    testWidgets('opens register screen when sign up is tapped on splash', (WidgetTester tester) async {
      await bootstrapSignedOutApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Don\'t have an account? Sign up'));
      await tester.pumpAndSettle();

      expect(find.text('Create account'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('returns to splash from login when back is pressed', (WidgetTester tester) async {
      await bootstrapSignedOutApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sign in'));
      await tester.pumpAndSettle();
      expect(find.text('Email'), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.text('Welcome!'), findsOneWidget);
    });
  });
}
