import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/widgets/current_weather_card.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class HomeBody extends StatelessWidget with ExtensionMixin {
  final bool isLoading;
  final CurrentWeather currentWeather;
  final HomeCubit cubit;

  const HomeBody({
    required this.cubit,
    required this.currentWeather,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: Dimens.m,
      vertical: Dimens.l,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            ExcludeSemantics(
              child: Icon(
                Icons.location_on_outlined,
                color: context.getColors().textPrimary,
              ),
            ),
            const SizedBox(width: Dimens.s),
            Text(
              currentWeather.locationName,
              style: AppTypography.headingMedium.copyWith(
                color: context.getColors().textPrimary,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => cubit.init(isRefreshPage: true),
              tooltip: Strings.of(context).homePageRefreshButtonTitle,
              icon: const Icon(Icons.refresh_outlined),
              color: context.getColors().textPrimary,
            ),
          ],
        ),
        const SizedBox(height: Dimens.l),
        CurrentWeatherCard(currentWeather: currentWeather),
      ],
    ),
  );
}
