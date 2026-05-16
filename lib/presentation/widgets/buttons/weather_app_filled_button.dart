import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/widgets/weather_app_loading_indicator.dart';
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
  Widget build(BuildContext context) {
    final Strings strings = Strings.of(context);
    final String semanticsLabel = isLoading ? strings.a11yButtonLoading(title) : title;

    return Semantics(
      button: true,
      enabled: !isLoading && onTap != null,
      label: semanticsLabel,
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Dimens.xm, horizontal: Dimens.m),
          decoration: BoxDecoration(
            color: context.getColors().accentYellow,
            borderRadius: BorderRadius.circular(Dimens.s),
          ),
          child: Center(
            child: ExcludeSemantics(
              child: isLoading
                  ? const SizedBox(
                      height: Dimens.l,
                      width: Dimens.l,
                      child: WeatherAppLoadingIndicator(),
                    )
                  : Text(
                      title,
                      style: AppTypography.bodyMediumDefault.copyWith(
                        color: context.getColors().textPrimary,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
