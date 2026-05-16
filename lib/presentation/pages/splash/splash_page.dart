import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/assets.gen.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_cubit.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_presentation_event.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_text_button.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/constants.dart';
import 'package:weather_app/style/dimens.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashCubit cubit = useBloc<SplashCubit>();

    useOnStreamChange(
      cubit.presentation,
      onData: (SplashPresentationEvent event) => _listener(event, context),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(Dimens.m),
        decoration: BoxDecoration(
          gradient: context.getColors().heroBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              SvgPicture.asset(
                Assets.images.svg.weather,
                width: WeatherAppConstants.splashWeatherIconSize,
                height: WeatherAppConstants.splashWeatherIconSize,
              ),
              Text(
                Strings.of(context).splashPageWelcomeTitle,
                style: AppTypography.displayLarge.copyWith(color: context.getColors().white),
              ),
              const SizedBox(height: Dimens.s),
              Text(
                Strings.of(context).splashPageWelcomeDescription,
                style: AppTypography.bodyMediumDefault.copyWith(color: context.getColors().white),
              ),
              const Spacer(),
              WeatherAppFilledButton(
                title: Strings.of(context).splashPageSignInButtonTitle,
                onTap: cubit.navigateToLogin,
              ),
              const SizedBox(height: Dimens.m),
              WeatherAppTextButton(
                title: Strings.of(context).splashPageDontHaveAccountTitle,
                onTap: cubit.navigateToRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(SplashPresentationEvent event, BuildContext context) => switch (event) {
    SplashNavigateToLoginEvent() => context.pushNamed(WeatherAppRoutes.login.name),
    SplashNavigateToRegisterEvent() => context.pushNamed(WeatherAppRoutes.register.name),
  };
}
