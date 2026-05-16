import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/login/body/login_body.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_cubit.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_presentation_event.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_state.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginCubit cubit = useBloc<LoginCubit>();
    final LoginState state = useBlocBuilder(cubit);

    useOnStreamChange(
      cubit.presentation,
      onData: (LoginPresentationEvent event) => _listener(event, context),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.getColors().surfaceLight,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: context.getColors().surfaceLight,
      body: SafeArea(
        child: switch (state) {
          LoginStateSubmitting() => LoginBody(
            cubit: cubit,
            isSubmitting: true,
          ),
          LoginStateLoaded() => LoginBody(
            cubit: cubit,
            isSubmitting: false,
          ),
        },
      ),
    );
  }

  void _listener(LoginPresentationEvent event, BuildContext context) => switch (event) {
    LoginNavigateHomeEvent() => context.goNamed(WeatherAppRoutes.home.name),
    LoginShowAuthErrorSnackBarEvent() => context.showWeatherAppSnackBar(
      message: Strings.of(context).authErrorGeneric,
    ),
  };
}
