import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class WeatherAppRadioButton extends StatelessWidget with ExtensionMixin {
  final String title;
  final String? semanticsLabel;
  final bool isSelected;
  final VoidCallback? onTap;

  const WeatherAppRadioButton({
    required this.title,
    required this.isSelected,
    this.semanticsLabel,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String label = semanticsLabel ?? title;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: <Widget>[
            ExcludeSemantics(
              child: Container(
                padding: const EdgeInsets.all(Dimens.xs),
                decoration: BoxDecoration(
                  color: context.getColors().white,
                  borderRadius: BorderRadius.circular(Dimens.s),
                ),
                child: Icon(
                  Icons.check,
                  color: isSelected ? context.getColors().textPrimary : context.getColors().white,
                ),
              ),
            ),
            const SizedBox(width: Dimens.s),
            ExcludeSemantics(
              child: Text(
                title,
                style: AppTypography.bodyMediumDefault.copyWith(color: context.getColors().textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
