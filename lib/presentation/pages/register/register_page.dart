import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/register/body/register_body.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_cubit.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_presentation_event.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_state.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterCubit cubit = useBloc<RegisterCubit>();
    final RegisterState state = useBlocBuilder(cubit);

    useOnStreamChange(
      cubit.presentation,
      onData: (RegisterPresentationEvent event) => _listener(event, context),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.getColors().surfaceLight,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: context.getColors().surfaceLight,
      body: SafeArea(
        child: switch (state) {
          RegisterStateSubmitting() => RegisterBody(
            cubit: cubit,
            isSubmitting: true,
          ),
          RegisterStateLoaded() => RegisterBody(
            cubit: cubit,
            isSubmitting: false,
          ),
        },
      ),
    );
  }

  void _listener(RegisterPresentationEvent event, BuildContext context) => switch (event) {
    RegisterNavigateHomeEvent() => context.goNamed(WeatherAppRoutes.home.name),
    RegisterShowAuthErrorSnackBarEvent() => context.showWeatherAppSnackBar(
      message: Strings.of(context).authErrorGeneric,
    ),
  };
}
