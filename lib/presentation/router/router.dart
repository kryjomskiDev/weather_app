import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/pages/home/home_page.dart';
import 'package:weather_app/presentation/pages/settings/settings_page.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: WeatherAppRoutes.home.path,
  routes: [
    GoRoute(
      path: WeatherAppRoutes.home.path,
      name: WeatherAppRoutes.home.name,
      pageBuilder: (_, __) => _noTransition(child: const HomePage()),
      routes: [
        GoRoute(
          path: WeatherAppRoutes.settings.path,
          name: WeatherAppRoutes.settings.name,
          pageBuilder: (_, state) => _defaultTransition(
            state: state,
            child: const SettingsPage(),
          ),
        ),
      ],
    ),
  ],
);

NoTransitionPage _noTransition({required Widget child}) => NoTransitionPage(child: child);

CustomTransitionPage _defaultTransition<T>({required GoRouterState state, required Widget child}) =>
    CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
