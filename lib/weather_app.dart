import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/themes.dart';
import 'package:weather_app/utils/l10n_model.dart';
import 'package:provider/provider.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

class WeatherApp extends StatelessWidget {
  final GoRouter appRouter;

  const WeatherApp({
    required this.appRouter,
    super.key,
  });

  @override
  Widget build(BuildContext context) => HookedBlocConfigProvider(
    injector: () => getIt.get,
    builderCondition: (Object? state) => state != null,
    listenerCondition: (Object? state) => state != null,
    child: _globalUnfocusKeyboard(
      context: context,
      child: MultiProvider(
        providers: <SingleChildWidget>[
          ListenableProvider<ThemeModel>(create: (BuildContext _) => ThemeModel()),
          ListenableProvider<L10nModel>(
            create: (BuildContext _) => L10nModel(getIt<SharedPreferences>()),
          ),
        ],
        child: Consumer<L10nModel>(
          builder: (BuildContext context, L10nModel model, Widget? child) => MaterialApp.router(
            routerConfig: appRouter,
            theme: ThemeData(
              colorScheme: const ColorScheme.light(),
              fontFamily: AppTypography.fontFamily,
            ),
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              Strings.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale(model.preferredLanguageCode),
            supportedLocales: const <Locale>[
              Locale(defaultLanguageCode),
              Locale(polishLanguageCode),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _globalUnfocusKeyboard({
    required BuildContext context,
    required Widget child,
  }) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => _hideKeyboard(context),
    child: child,
  );

  void _hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
