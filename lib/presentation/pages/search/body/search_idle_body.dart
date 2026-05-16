import 'package:flutter/material.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class SearchIdleBody extends StatelessWidget {
  const SearchIdleBody({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimens.m),
      child: Text(
        Strings.of(context).searchPageEmptyMessage,
        textAlign: TextAlign.center,
        style: AppTypography.bodyMediumDefault.copyWith(color: context.getColors().textPrimary),
      ),
    ),
  );
}
