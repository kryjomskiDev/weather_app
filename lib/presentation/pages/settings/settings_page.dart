import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/settings/body/settings_body.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_presentation_event.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_state.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
import 'package:weather_app/utils/hooks_use_once.dart';
import 'package:weather_app/utils/l10n_model.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsCubit cubit = useBloc<SettingsCubit>();

    final SettingsState state = useBlocBuilder(
      cubit,
    );

    useOnStreamChange(
      cubit.presentation,
      onData: (SettingsPresentationEvent event) => _listener(cubit, event, context),
    );

    useOnce(cubit.init);

    return Scaffold(
      backgroundColor: context.getColors().surfaceLight,
      body: SafeArea(
        child: switch (state) {
          SettingsStateLoaded() => SettingsBody(
            selectedLanguage: state.selectedLanguageCode,
            cubit: cubit,
          ),
          SettingsStateLoading() => WeatherAppLoadingIndicator(color: context.getColors().white),
          SettingsStateError() => const SizedBox.shrink(),
        },
      ),
    );
  }

  void _listener(SettingsCubit cubit, SettingsPresentationEvent event, BuildContext context) => switch (event) {
    LogoutFailedEvent() => () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Strings.of(context).authErrorGeneric)),
      );
    }(),
    LanguageSelectedEvent() => _onLanguageSelected(cubit, context),
  };

  void _onLanguageSelected(SettingsCubit cubit, BuildContext context) {
    context.read<L10nModel>().switchLanguage();
    cubit.onLanguageSelected();
  }
}
