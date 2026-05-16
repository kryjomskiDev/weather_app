import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/current_weather_extension.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/widgets/weather_app_card.dart';
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
            Icon(
              Icons.location_on_outlined,
              color: context.getColors().textPrimary,
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
              icon: const Icon(Icons.refresh_outlined),
              color: context.getColors().textPrimary,
            ),
          ],
        ),
        const SizedBox(height: Dimens.l),
        WeatherAppCard(
          child: Column(
            children: <Widget>[
              Image.network(
                currentWeather.iconPath,
                fit: BoxFit.cover,
                height: Dimens.xxxxc + Dimens.xxxc,
                errorBuilder: (_, _, _) => Icon(
                  Icons.do_not_disturb_alt_rounded,
                  color: context.getColors().white,
                ),
              ),
              const SizedBox(height: Dimens.l),
              Text(
                Strings.of(context).homePageTemperature(currentWeather.formattedTemperature),
                textAlign: TextAlign.center,
                style: AppTypography.headingBig.copyWith(color: context.getColors().white),
              ),
              Text(
                currentWeather.title,
                textAlign: TextAlign.center,
                style: AppTypography.headingLarge.copyWith(color: context.getColors().white),
              ),
              Text(
                currentWeather.description,
                textAlign: TextAlign.center,
                style: AppTypography.bodyRegular.copyWith(color: context.getColors().white),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
