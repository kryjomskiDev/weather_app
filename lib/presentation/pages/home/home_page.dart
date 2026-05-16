import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/presentation/pages/home/body/home_body.dart';
import 'package:weather_app/presentation/pages/home/body/home_error_body.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_state.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/hooks_use_once.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = useBloc<HomeCubit>();
    final HomeState state = useBlocBuilder(cubit);

    useOnce(cubit.init);

    return Scaffold(
      backgroundColor: context.getColors().surfaceLight,
      body: SafeArea(
        child: switch (state) {
          HomeStateLoaded(currentWeather: final CurrentWeather currentWeather) => HomeBody(
            currentWeather: currentWeather,
            cubit: cubit,
          ),
          HomeStateLoading(currentWeather: final CurrentWeather currentWeather) => HomeBody(
            currentWeather: currentWeather,
            cubit: cubit,
            isLoading: true,
          ),
          HomeStateLoading() => WeatherAppLoadingIndicator(color: context.getColors().white),
          HomeStateError(error: final GenericError error) => HomeLocationErrorBody(
            cubit: cubit,
            error: error,
          ),
        },
      ),
    );
  }
}
