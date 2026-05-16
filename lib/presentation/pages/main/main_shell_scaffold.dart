import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';

class MainShellScaffold extends HookWidget with ExtensionMixin {
  final StatefulNavigationShell navigationShell;

  const MainShellScaffold({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.getColors().surfaceLight,
    body: navigationShell,
    bottomNavigationBar: DecoratedBox(
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
  );
}
