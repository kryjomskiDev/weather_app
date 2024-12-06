import 'package:flutter/material.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class HomeLocationErrorBody extends StatelessWidget {
  final HomeCubit cubit;
  final HomeBodyErrorType type;

  const HomeLocationErrorBody({
    required this.cubit,
    required this.type,
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
          children: [
            const Spacer(),
            Text(
              _getTitle(context),
              textAlign: TextAlign.center,
              style: AppTypography.headingSmall.copyWith(color: context.getColors().white),
            ),
            const Spacer(),
            WeatherAppFilledButton(
              title: Strings.of(context).homePageRefreshButtonTitle,
              onTap: () => cubit.init(),
            ),
            const SizedBox(height: Dimens.m),
            WeatherAppFilledButton(
              title: Strings.of(context).homePageSettingsButtonTitle,
              onTap: () => cubit.goToSettings(),
            ),
          ],
        ),
      );

  String _getTitle(BuildContext context) => switch (type) {
        HomeBodyErrorType.error => Strings.of(context).homePageErrorTitle,
        HomeBodyErrorType.locationDisabled => Strings.of(context).homePageLocationDisabledTitle,
        HomeBodyErrorType.locationPermissionDenied => Strings.of(context).homePageLocationPermissionDeniedTitle,
      };
}

enum HomeBodyErrorType {
  locationDisabled,
  locationPermissionDenied,
  error,
}
