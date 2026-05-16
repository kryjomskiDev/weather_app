import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/presentation/widgets/current_weather_card.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class SearchResultBody extends StatelessWidget {
  final CurrentWeather currentWeather;

  const SearchResultBody({required this.currentWeather, super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: Dimens.m,
      vertical: Dimens.l,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          currentWeather.locationName,
          style: AppTypography.headingMedium.copyWith(color: context.getColors().textPrimary),
        ),
        const SizedBox(height: Dimens.l),
        CurrentWeatherCard(currentWeather: currentWeather),
      ],
    ),
  );
}
