import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter getMockRouter(GoRoute initialRoute) => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: initialRoute.path,
      routes: [
        initialRoute,
      ],
    );
