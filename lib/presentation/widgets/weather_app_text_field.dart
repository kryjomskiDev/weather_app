import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/extensions/build_context_extension.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/style/app_typography.dart';
import 'package:weather_app/style/dimens.dart';

class WeatherAppTextField extends HookWidget {
  final String? label;
  final bool isPassword;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hint;
  final String? errorMessage;
  final bool? enabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final TextAlign? textAlign;
  final bool requestFocus;
  final Color? fillColor;
  final EdgeInsets? scrollPadding;
  final Iterable<String>? autofillHints;

  const WeatherAppTextField({
    this.label,
    this.controller,
    this.onChanged,
    this.hint,
    this.errorMessage,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onEditingComplete,
    this.textAlign,
    this.requestFocus = false,
    this.fillColor,
    this.scrollPadding,
    super.key,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> hasFocus = useState(false);
    final ValueNotifier<bool> isObscure = useState(true);
    final FocusNode focusNode = useFocusNode();

    return Focus(
      onFocusChange: (bool value) {
        hasFocus.value = value;
        if (!value) {
          onEditingComplete?.call();
        } else {
          if (requestFocus) focusNode.requestFocus();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label != null) ...<Widget>[
            Text(
              label!,
              style: AppTypography.caption2Medium.copyWith(color: _getLabelColor(context)),
            ),
            const SizedBox(height: Dimens.xs),
          ],
          DecoratedBox(
            decoration: BoxDecoration(
              color: _getOuterColor(context: context, hasFocus: hasFocus.value),
              border: Border.all(
                color: Colors.transparent,
                width: Dimens.xxs,
              ),
              borderRadius: BorderRadius.circular(Dimens.s),
            ),
            child: TextField(
              scrollPadding: scrollPadding ?? const EdgeInsets.all(Dimens.ms),
              inputFormatters: inputFormatters,
              enabled: enabled,
              controller: controller,
              onChanged: onChanged,
              focusNode: focusNode,
              obscureText: isObscure.value && isPassword,
              cursorColor: context.getColors().textPrimary,
              autofillHints: (enabled ?? true) ? autofillHints : null,
              style: AppTypography.bodyRegular.copyWith(
                color: enabled != false ? context.getColors().textPrimary : context.getColors().textSecondary,
              ),
              keyboardType: keyboardType,
              obscuringCharacter: '*',
              textAlign: textAlign ?? TextAlign.start,
              decoration: InputDecoration(
                hintText: hint,
                fillColor: fillColor ?? context.getColors().white,
                hintStyle: AppTypography.bodyRegular.copyWith(color: context.getColors().textSecondary),
                filled: true,
                suffixIcon: isPassword
                    ? IconButton(
                        tooltip: isObscure.value
                            ? Strings.of(context).a11yShowPassword
                            : Strings.of(context).a11yHidePassword,
                        icon: Icon(
                          isObscure.value ? Icons.visibility : Icons.visibility_off,
                          color: context.getColors().textPrimary,
                        ),
                        onPressed: () {
                          isObscure.value = !isObscure.value;
                        },
                      )
                    : null,
                enabledBorder: _getInputBorder(
                  context: context,
                  hasFocus: hasFocus.value,
                ),
                disabledBorder: _getInputBorder(
                  context: context,
                  hasFocus: hasFocus.value,
                ),
                focusedBorder: _getInputBorder(
                  context: context,
                  hasFocus: hasFocus.value,
                ),
                contentPadding: const EdgeInsetsDirectional.symmetric(
                  horizontal: Dimens.xm,
                  vertical: Dimens.m,
                ),
              ),
            ),
          ),
          if (errorMessage != null) ...<Widget>[
            const SizedBox(height: Dimens.xs),
            Row(
              children: <Widget>[
                ExcludeSemantics(
                  child: Icon(Icons.error, color: context.getColors().error),
                ),
                const SizedBox(width: Dimens.xxxs),
                Expanded(
                  child: Text(
                    errorMessage!,
                    style: AppTypography.footnoteRegular.copyWith(color: context.getColors().error),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  OutlineInputBorder _getInputBorder({
    required BuildContext context,
    required bool hasFocus,
  }) => OutlineInputBorder(
    borderSide: BorderSide(
      color: context.getColors().textPrimary,
      width: Dimens.xxxs,
    ),
    borderRadius: BorderRadius.circular(Dimens.s),
  );

  Color _getLabelColor(BuildContext context) =>
      enabled == true ? context.getColors().textPrimary : context.getColors().textSecondary;

  Color _getOuterColor({
    required BuildContext context,
    required bool hasFocus,
  }) {
    if (hasFocus) {
      return context.getColors().accentYellowDeep;
    }
    return Colors.transparent;
  }
}
