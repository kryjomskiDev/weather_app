import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/pages/home/home_page.dart';
import 'package:weather_app/presentation/pages/login/login_page.dart';
import 'package:weather_app/presentation/pages/main/main_shell_scaffold.dart';
import 'package:weather_app/presentation/pages/register/register_page.dart';
import 'package:weather_app/presentation/pages/search/search_page.dart';
import 'package:weather_app/presentation/pages/settings/settings_page.dart';
import 'package:weather_app/presentation/pages/splash/splash_page.dart';
import 'package:weather_app/presentation/router/weather_app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: WeatherAppRoutes.splash.path,
  routes: <RouteBase>[
    GoRoute(
      path: WeatherAppRoutes.splash.path,
      name: WeatherAppRoutes.splash.name,
      pageBuilder: (BuildContext context, GoRouterState state) => _noTransition(child: const SplashPage()),
      routes: <RouteBase>[
        GoRoute(
          path: WeatherAppRoutes.login.path,
          name: WeatherAppRoutes.login.name,
          pageBuilder: (BuildContext context, GoRouterState state) => _defaultTransition(
            state: state,
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: WeatherAppRoutes.register.path,
          name: WeatherAppRoutes.register.name,
          pageBuilder: (BuildContext context, GoRouterState state) => _defaultTransition(
            state: state,
            child: const RegisterPage(),
          ),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder:
          (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
          ) => MainShellScaffold(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: WeatherAppRoutes.home.path,
              name: WeatherAppRoutes.home.name,
              pageBuilder: (BuildContext context, GoRouterState state) => _defaultTransition(
                state: state,
                child: const HomePage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: WeatherAppRoutes.search.path,
              name: WeatherAppRoutes.search.name,
              pageBuilder: (BuildContext context, GoRouterState state) => _defaultTransition(
                state: state,
                child: const SearchPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: WeatherAppRoutes.settings.path,
              name: WeatherAppRoutes.settings.name,
              pageBuilder: (BuildContext context, GoRouterState state) => _defaultTransition(
                state: state,
                child: const SettingsPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

NoTransitionPage<void> _noTransition({required Widget child}) => NoTransitionPage<void>(child: child);

CustomTransitionPage<T> _defaultTransition<T>({required GoRouterState state, required Widget child}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
