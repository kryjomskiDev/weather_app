import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/presentation/widgets/app_loading_indicator.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class WeatherAppFilledButton extends StatelessWidget with ExtensionMixin {
  final bool isLoading;
  final VoidCallback? onTap;
  final String title;

  const WeatherAppFilledButton({
    required this.title,
    this.onTap,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Dimens.xm, horizontal: Dimens.m),
          decoration: BoxDecoration(
            color: context.getColors().white,
            borderRadius: BorderRadius.circular(Dimens.s),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: Dimens.l,
                    width: Dimens.l,
                    child: AppLoadingIndicator(),
                  )
                : Text(
                    title,
                    style: AppTypography.bodyMediumDefault.copyWith(color: context.getColors().blue),
                  ),
          ),
        ),
      );
}
