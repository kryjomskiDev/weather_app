import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/presentation/widgets/session_expiration_checker/cubit/session_expiration_checker_cubit.dart';
import 'package:weather_app/presentation/widgets/session_expiration_checker/cubit/session_expiration_checker_state.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
import 'package:weather_app/utils/hooks_use_once.dart';
import 'package:weather_app/utils/ignore_else_state.dart';
import 'package:weather_app/utils/navigation_callback.dart';

class SessionExpirationChecker extends HookWidget {
  final AppNavigationCallback onUnauthenticated;
  final AppNavigationCallback onAuthenticated;
  final Widget child;

  const SessionExpirationChecker({
    required this.onUnauthenticated,
    required this.onAuthenticated,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SessionExpirationCheckerCubit cubit = useBloc<SessionExpirationCheckerCubit>();
    final SessionExpirationCheckerState state = useBlocBuilder(cubit);

    useBlocListener(cubit, _listener);
    useOnce(cubit.init);

    return switch (state) {
      SessionExpirationCheckerIdleState() => const Scaffold(
        body: WeatherAppLoadingIndicator(),
      ),
      _ => child,
    };
  }

  void _listener(SessionExpirationCheckerCubit cubit, SessionExpirationCheckerState state, BuildContext context) =>
      switch (state) {
        SessionExpirationCheckerUnauthenticatedState() => onUnauthenticated(context),
        SessionExpirationCheckerAuthenticatedState() => onAuthenticated(context),
        _ => doNothing(),
      };
}
