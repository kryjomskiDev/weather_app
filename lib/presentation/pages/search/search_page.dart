import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/search/body/search_error_body.dart';
import 'package:weather_app/presentation/pages/search/body/search_idle_body.dart';
import 'package:weather_app/presentation/pages/search/body/search_result_body.dart';
import 'package:weather_app/presentation/pages/search/cubit/search_cubit.dart';
import 'package:weather_app/presentation/pages/search/cubit/search_state.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
import 'package:weather_app/presentation/widgets/weather_app_text_field.dart';
import 'package:weather_app/style/dimens.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchCubit cubit = useBloc<SearchCubit>();
    final SearchState state = useBlocBuilder(cubit);
    final TextEditingController controller = useTextEditingController();

    return Scaffold(
      backgroundColor: context.getColors().surfaceLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(Dimens.m, Dimens.m, Dimens.m, Dimens.s),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: WeatherAppTextField(
                      controller: controller,
                      hint: Strings.of(context).searchPageHint,
                      onEditingComplete: () => cubit.search(controller.text),
                    ),
                  ),
                  const SizedBox(width: Dimens.s),
                  IconButton(
                    onPressed: () => cubit.search(controller.text),
                    tooltip: Strings.of(context).a11ySearchSubmit,
                    icon: Icon(
                      Icons.search,
                      color: context.getColors().textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: switch (state) {
                SearchStateInitial() => const SearchIdleBody(),
                SearchStateLoading() => WeatherAppLoadingIndicator(color: context.getColors().blue),
                SearchStateLoaded(currentWeather: final CurrentWeather currentWeather) => SearchResultBody(
                  currentWeather: currentWeather,
                ),
                SearchStateError(error: final GenericError error) => SearchErrorBody(
                  cubit: cubit,
                  error: error,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
