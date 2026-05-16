import 'package:flutter/material.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/search/cubit/search_cubit.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/error_handling/errors/http_errors.dart';

class SearchErrorBody extends StatelessWidget {
  final SearchCubit cubit;
  final GenericError error;

  const SearchErrorBody({
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
          _getMessage(context),
          textAlign: TextAlign.center,
          style: AppTypography.headingSmall.copyWith(color: context.getColors().textPrimary),
        ),
        const Spacer(),
        WeatherAppFilledButton(
          title: Strings.of(context).searchPageTryAgain,
          onTap: cubit.retry,
        ),
      ],
    ),
  );

  String _getMessage(BuildContext context) => switch (error) {
    NotFoundError() => Strings.of(context).searchPageCityNotFound,
    _ => Strings.of(context).searchPageErrorGeneric,
  };
}
