import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/extensions/extension_mixin.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_radio_button.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';
import 'package:weather_app/utils/l10n_model.dart';

class SettingsBody extends HookWidget with ExtensionMixin {
  final SettingsCubit cubit;
  final String selectedLanguage;
  final LocationPermissionStatus locationPermissionStatus;

  const SettingsBody({
    required this.cubit,
    required this.selectedLanguage,
    required this.locationPermissionStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useState(selectedLanguage);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: Dimens.l, horizontal: Dimens.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Strings.of(context).settingsPageLanguage,
            style: AppTypography.headingSmall.copyWith(color: context.getColors().white),
          ),
          const SizedBox(height: Dimens.m),
          WeatherAppRadioButton(
            isSelected: controller.value == englishLanguageCode,
            title: Strings.of(context).settingsPageLanguageEnglish,
            onTap: () {
              controller.value = englishLanguageCode;
              cubit.selectLangauge(controller.value);
            },
          ),
          const SizedBox(height: Dimens.s),
          WeatherAppRadioButton(
            isSelected: controller.value == polishLanguageCode,
            title: Strings.of(context).settingsPageLanguagePolish,
            onTap: () async {
              controller.value = polishLanguageCode;
              await cubit.selectLangauge(controller.value);
            },
          ),
          const SizedBox(height: Dimens.l),
          Text(
            _isPermissionDenied
                ? Strings.of(context).settingsPageLocationPermissionDenied
                : Strings.of(context).settingsPageLocationPermissionGranted,
            style: AppTypography.headingSmall.copyWith(color: context.getColors().white),
          ),
          const SizedBox(height: Dimens.m),
          Row(
            children: [
              Icon(Icons.info_outline, color: context.getColors().white),
              const SizedBox(width: Dimens.s),
              Expanded(
                child: Text(
                  Strings.of(context).settingsPageLocationPermissionInfo,
                  style: AppTypography.caption1Medium.copyWith(color: context.getColors().white),
                ),
              ),
            ],
          ),
          const Spacer(),
          WeatherAppFilledButton(
            title: Strings.of(context).settingsPageCloseButtonTitle,
            onTap: cubit.closePage,
          ),
        ],
      ),
    );
  }

  bool get _isPermissionDenied =>
      locationPermissionStatus == LocationPermissionStatus.denied ||
      locationPermissionStatus == LocationPermissionStatus.deniedForever;
}
