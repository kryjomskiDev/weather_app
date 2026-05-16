import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_cubit.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_presentation_event.dart';
import 'package:weather_app/presentation/pages/main/cubit/main_session_state.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
import 'package:weather_app/utils/hooks_use_once.dart';

class MainShellScaffold extends HookWidget with ExtensionMixin {
  final StatefulNavigationShell navigationShell;

  const MainShellScaffold({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MainSessionCubit sessionCubit = useBloc<MainSessionCubit>();
    final MainSessionState state = useBlocBuilder(sessionCubit);

    useOnStreamChange(
      sessionCubit.presentation,
      onData: (MainSessionPresentationEvent event) => _listener(event, context),
    );

    useOnce(sessionCubit.init);

    return Scaffold(
      backgroundColor: context.getColors().surfaceLight,
      body: switch (state) {
        MainSessionStateLoading() => WeatherAppLoadingIndicator(color: context.getColors().white),
        MainSessionStateLoaded() => navigationShell,
      },
      bottomNavigationBar: switch (state) {
        MainSessionStateLoaded() => DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: context.getColors().blueLight,
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: navigationShell.currentIndex,
            backgroundColor: context.getColors().surfaceLight,
            selectedItemColor: context.getColors().blue,
            unselectedItemColor: context.getColors().textSecondary,
            onTap: navigationShell.goBranch,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: Strings.of(context).mainNavHome,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: Strings.of(context).mainNavSearch,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                activeIcon: const Icon(Icons.settings),
                label: Strings.of(context).mainNavSettings,
              ),
            ],
          ),
        ),
        _ => null,
      },
    );
  }

  void _listener(MainSessionPresentationEvent event, BuildContext context) => switch (event) {
    MainSessionExpiredEvent() => context.goNamed(WeatherAppRoutes.splash.name),
  };
}
