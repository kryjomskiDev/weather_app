import 'package:flutter/material.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class WeatherAppRadioButton extends StatelessWidget with ExtensionMixin {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const WeatherAppRadioButton({
    required this.title,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(Dimens.xs),
                decoration: BoxDecoration(
                  color: context.getColors().white,
                  borderRadius: BorderRadius.circular(Dimens.s),
                ),
                child: Icon(
                  Icons.check,
                  color: isSelected ? context.getColors().blue : context.getColors().white,
                )),
            const SizedBox(width: Dimens.s),
            Text(
              title,
              style: AppTypography.bodyMediumDefault.copyWith(color: context.getColors().white),
            ),
          ],
        ),
      );
}
