import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/extensions/current_weather_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/widgets/weather_app_card.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather currentWeather;

  const CurrentWeatherCard({required this.currentWeather, super.key});

  @override
  Widget build(BuildContext context) => WeatherAppCard(
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
  );
}
