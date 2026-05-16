import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

  const SettingsBody({
    required this.cubit,
    required this.selectedLanguage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> controller = useState<String>(selectedLanguage);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: Dimens.l, horizontal: Dimens.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: Dimens.l),
          Text(
            Strings.of(context).settingsPageLanguage,
            style: AppTypography.headingSmall.copyWith(color: context.getColors().textPrimary),
          ),
          const SizedBox(height: Dimens.m),
          WeatherAppRadioButton(
            key: const Key('en-language-button'),
            isSelected: controller.value == englishLanguageCode,
            title: Strings.of(context).settingsPageLanguageEnglish,
            semanticsLabel: Strings.of(context).a11yLanguageOption(
              Strings.of(context).settingsPageLanguageEnglish,
              controller.value == englishLanguageCode
                  ? Strings.of(context).a11ySelected
                  : Strings.of(context).a11yNotSelected,
            ),
            onTap: () {
              controller.value = englishLanguageCode;
              cubit.selectLanguage(controller.value);
            },
          ),
          const SizedBox(height: Dimens.s),
          WeatherAppRadioButton(
            key: const Key('pl-language-button'),
            isSelected: controller.value == polishLanguageCode,
            title: Strings.of(context).settingsPageLanguagePolish,
            semanticsLabel: Strings.of(context).a11yLanguageOption(
              Strings.of(context).settingsPageLanguagePolish,
              controller.value == polishLanguageCode
                  ? Strings.of(context).a11ySelected
                  : Strings.of(context).a11yNotSelected,
            ),
            onTap: () async {
              controller.value = polishLanguageCode;
              await cubit.selectLanguage(controller.value);
            },
          ),
          const SizedBox(height: Dimens.m),
          const Spacer(),
          WeatherAppFilledButton(
            title: Strings.of(context).settingsPageLogoutTitle,
            onTap: cubit.logout,
          ),
        ],
      ),
    );
  }
}
