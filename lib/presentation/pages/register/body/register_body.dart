import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_cubit.dart';
import 'package:weather_app/presentation/widgets/buttons/weather_app_filled_button.dart';
import 'package:weather_app/presentation/widgets/weather_app_text_field.dart';
import 'package:weather_app/style/dimens.dart';

class RegisterBody extends HookWidget {
  final RegisterCubit cubit;
  final bool isSubmitting;

  const RegisterBody({
    required this.cubit,
    required this.isSubmitting,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.l, vertical: Dimens.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            Strings.of(context).authRegisterTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: Dimens.l),
          WeatherAppTextField(
            label: Strings.of(context).authEmailLabel,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const <String>[AutofillHints.email],
          ),
          const SizedBox(height: Dimens.m),
          WeatherAppTextField(
            label: Strings.of(context).authPasswordLabel,
            controller: passwordController,
            autofillHints: const <String>[AutofillHints.newPassword],
            isPassword: true,
          ),
          const SizedBox(height: Dimens.l),
          WeatherAppFilledButton(
            title: Strings.of(context).authRegisterButton,
            isLoading: isSubmitting,
            onTap: isSubmitting
                ? null
                : () => cubit.register(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
          ),
        ],
      ),
    );
  }
}
