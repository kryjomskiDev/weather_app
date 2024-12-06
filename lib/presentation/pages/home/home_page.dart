import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/presentation/pages/home/body/home_body.dart';
import 'package:weather_app/presentation/pages/home/body/home_error_body.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_state.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';
import 'package:weather_app/presentation/widgets/app_loading_indicator.dart';
import 'package:weather_app/presentation/widgets/weather_app_scaffold.dart';
import 'package:weather_app/utils/hooks_use_once.dart';
import 'package:weather_app/utils/ignore_else_state.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<HomeCubit>();

    final state = useBlocBuilder(
      cubit,
      buildWhen: _buildWhen,
    );

    useBlocListener(
      cubit,
      _listener,
      listenWhen: _listenWhen,
    );

    useOnce(cubit.init);

    return WeatherAppScaffold(
      body: _builder(cubit, state, context),
    );
  }

  bool _buildWhen(HomeState state) => state is HomeStateBuilder;

  bool _listenWhen(HomeState state) => state is HomeStateListener;

  void _listener(HomeCubit cubit, HomeState state, BuildContext context) => switch (state) {
        HomeStateGoToSettings() => context.pushNamed(WeatherAppRoutes.settings.name),
        _ => doNothing,
      };

  Widget _builder(HomeCubit cubit, HomeState state, BuildContext context) => switch (state) {
        HomeStateLoaded(
          currentWeather: final CurrentWeather currentWeather,
        ) =>
          HomeBody(
            currentWeather: currentWeather,
            cubit: cubit,
          ),
        HomeStateRefreshPage(
          currentWeather: final CurrentWeather currentWeather,
        ) =>
          HomeBody(
            currentWeather: currentWeather,
            cubit: cubit,
            isLaoding: true,
          ),
        HomeStateLoading() => AppLoadingIndicator(
            color: context.getColors().white,
          ),
        HomeStateError() => HomeLocationErrorBody(
            cubit: cubit,
            type: HomeBodyErrorType.error,
          ),
        HomeStateLocationDisabled() => HomeLocationErrorBody(
            cubit: cubit,
            type: HomeBodyErrorType.locationDisabled,
          ),
        HomeStateLocationPermissionDenied() => HomeLocationErrorBody(
            cubit: cubit,
            type: HomeBodyErrorType.locationPermissionDenied,
          ),
        _ => const SizedBox.shrink(),
      };
}
