import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_cubit.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_presentation_event.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_state.dart';

void main() {
  group('SplashCubit', () {
    test('has initial loaded state', () {
      final SplashCubit cubit = SplashCubit();
      expect(cubit.state, const SplashStateLoaded());
      cubit.close();
    });

    test('navigateToLogin emits SplashNavigateToLoginEvent', () async {
      final SplashCubit cubit = SplashCubit();
      final List<SplashPresentationEvent> events = <SplashPresentationEvent>[];
      final StreamSubscription<SplashPresentationEvent> sub = cubit.presentation.listen(events.add);

      cubit.navigateToLogin();
      await pumpEventQueue();

      expect(events, contains(const SplashNavigateToLoginEvent()));
      await sub.cancel();
      await cubit.close();
    });

    test('navigateToRegister emits SplashNavigateToRegisterEvent', () async {
      final SplashCubit cubit = SplashCubit();
      final List<SplashPresentationEvent> events = <SplashPresentationEvent>[];
      final StreamSubscription<SplashPresentationEvent> sub = cubit.presentation.listen(events.add);

      cubit.navigateToRegister();
      await pumpEventQueue();

      expect(events, contains(const SplashNavigateToRegisterEvent()));
      await sub.cancel();
      await cubit.close();
    });
  });
}
