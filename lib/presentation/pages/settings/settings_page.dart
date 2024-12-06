import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/presentation/pages/settings/body/settings_body.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_state.dart';
import 'package:weather_app/presentation/widgets/app_loading_indicator.dart';
import 'package:weather_app/presentation/widgets/weather_app_scaffold.dart';
import 'package:weather_app/utils/hooks_use_once.dart';
import 'package:weather_app/utils/ignore_else_state.dart';
import 'package:weather_app/utils/l10n_model.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<SettingsCubit>();

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

  bool _buildWhen(SettingsState state) => state is SettingsStateBuilder;

  bool _listenWhen(SettingsState state) => state is SettingsStateListener;

  void _listener(SettingsCubit cubit, SettingsState state, BuildContext context) => switch (state) {
        SettingsStateClosePage() => context.pop(),
        SettingsStateLanguageSelected() => _onLanguageSelected(cubit, context),
        _ => doNothing,
      };

  void _onLanguageSelected(SettingsCubit cubit, BuildContext context) {
    context.read<L10nModel>().switchLanguage();
    cubit.onLanguageSelected();
  }

  Widget _builder(SettingsCubit cubit, SettingsState state, BuildContext context) => switch (state) {
        SettingsStateLoaded(
          selectedLanguageCode: final String selectedLanguage,
          locationPermissionStatus: final LocationPermissionStatus locationPermissionStatus,
        ) =>
          SettingsBody(
            selectedLanguage: selectedLanguage,
            cubit: cubit,
            locationPermissionStatus: locationPermissionStatus,
          ),
        SettingsStateLoading() => AppLoadingIndicator(
            color: context.getColors().white,
          ),
        _ => const SizedBox.shrink(),
      };
}
