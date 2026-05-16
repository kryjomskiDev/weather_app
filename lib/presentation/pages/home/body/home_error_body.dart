import 'package:flutter/material.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/other_errors.dart';

class HomeLocationErrorBody extends StatelessWidget {
  final HomeCubit cubit;
  final GenericError error;

  const HomeLocationErrorBody({
    required this.cubit,
    required this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: Dimens.m,
      vertical: Dimens.l,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Spacer(),
        Text(
          _getTitle(context),
          textAlign: TextAlign.center,
          style: AppTypography.headingSmall.copyWith(color: context.getColors().textPrimary),
        ),
        const Spacer(),
        WeatherAppFilledButton(
          title: Strings.of(context).homePageRefreshButtonTitle,
          onTap: () => cubit.init(),
        ),
      ],
    ),
  );

  String _getTitle(BuildContext context) => switch (error) {
    LocationServiceDisabledError() => Strings.of(context).homePageLocationDisabledTitle,
    LocationPermissionDeniedForeverError() => Strings.of(context).homePageLocationPermissionDeniedTitle,
    _ => Strings.of(context).homePageErrorTitle,
  };
}
