import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class SearchPage extends StatelessWidget with ExtensionMixin {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.getColors().surfaceLight,
    body: Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimens.m),
        child: Text(
          Strings.of(context).searchPagePlaceholder,
          textAlign: TextAlign.center,
          style: AppTypography.bodyMediumDefault.copyWith(color: context.getColors().textPrimary),
        ),
      ),
    ),
  );
}
