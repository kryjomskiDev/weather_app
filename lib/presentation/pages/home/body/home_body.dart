import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';
import 'package:weather_app/style/number_formats.dart';

class HomeBody extends StatelessWidget with ExtensionMixin {
  final bool isLaoding;
  final CurrentWeather currentWeather;
  final HomeCubit cubit;

  const HomeBody({
    required this.cubit,
    required this.currentWeather,
    this.isLaoding = false,
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
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: context.getColors().white,
                ),
                const SizedBox(width: Dimens.s),
                Text(
                  currentWeather.locationName,
                  style: AppTypography.headingMedium.copyWith(color: context.getColors().white),
                ),
              ],
            ),
            const SizedBox(height: Dimens.l),
            Image.network(
              _iconPath,
              fit: BoxFit.cover,
              height: Dimens.xxxxc + Dimens.xxxc,
              errorBuilder: (_, __, ___) => Icon(
                Icons.do_not_disturb_alt_rounded,
                color: context.getColors().white,
              ),
            ),
            const SizedBox(height: Dimens.l),
            Text(
              Strings.of(context).homePageTemperature(temperature.format(currentWeather.temperature)),
              textAlign: TextAlign.center,
              style: AppTypography.headingBig.copyWith(color: context.getColors().white),
            ),
            Text(
              currentWeather.title,
              textAlign: TextAlign.center,
              style: AppTypography.headingLarge.copyWith(color: context.getColors().white),
            ),
            Text(
              currentWeather.descritpion,
              textAlign: TextAlign.center,
              style: AppTypography.bodyRegular.copyWith(color: context.getColors().white),
            ),
            const Spacer(),
            WeatherAppFilledButton(
              title: Strings.of(context).homePageRefreshButtonTitle,
              isLoading: isLaoding,
              onTap: () => cubit.init(isRefreshPage: true),
            ),
            const SizedBox(height: Dimens.s),
            WeatherAppFilledButton(
              title: Strings.of(context).homePageSettingsButtonTitle,
              onTap: isLaoding ? null : cubit.goToSettings,
            ),
          ],
        ),
      );

  String get _iconPath => 'https://openweathermap.org/img/wn/${currentWeather.icon}@2x.png';
}
