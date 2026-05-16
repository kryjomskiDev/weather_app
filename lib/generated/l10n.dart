// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Strings {
  Strings();

  static Strings? _current;

  static Strings get current {
    assert(_current != null,
        'No instance of Strings was loaded. Try to initialize the Strings delegate before accessing Strings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Strings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Strings();
      Strings._current = instance;

      return instance;
    });
  }

  static Strings of(BuildContext context) {
    final instance = Strings.maybeOf(context);
    assert(instance != null,
        'No instance of Strings present in the widget tree. Did you add Strings.delegate in localizationsDelegates?');
    return instance!;
  }

  static Strings? maybeOf(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  /// `Refresh`
  String get homePageRefreshButtonTitle {
    return Intl.message(
      'Refresh',
      name: 'homePageRefreshButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get homePageSettingsButtonTitle {
    return Intl.message(
      'Settings',
      name: 'homePageSettingsButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `{temperature}°C`
  String homePageTemperature(Object temperature) {
    return Intl.message(
      '$temperature°C',
      name: 'homePageTemperature',
      desc: '',
      args: [temperature],
    );
  }

  /// `Something went wrong, please try again`
  String get homePageErrorTitle {
    return Intl.message(
      'Something went wrong, please try again',
      name: 'homePageErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location is disabled, enable it to continue`
  String get homePageLocationDisabledTitle {
    return Intl.message(
      'Location is disabled, enable it to continue',
      name: 'homePageLocationDisabledTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location permission is denied, grant it in system settings`
  String get homePageLocationPermissionDeniedTitle {
    return Intl.message(
      'Location permission is denied, grant it in system settings',
      name: 'homePageLocationPermissionDeniedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsPageLanguage {
    return Intl.message(
      'Language',
      name: 'settingsPageLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settingsPageLanguageEnglish {
    return Intl.message(
      'English',
      name: 'settingsPageLanguageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Polish`
  String get settingsPageLanguagePolish {
    return Intl.message(
      'Polish',
      name: 'settingsPageLanguagePolish',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get settingsPageCloseButtonTitle {
    return Intl.message(
      'Close',
      name: 'settingsPageCloseButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get settingsPageLogoutTitle {
    return Intl.message(
      'Log out',
      name: 'settingsPageLogoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location permission`
  String get settingsPageLocationPermission {
    return Intl.message(
      'Location permission',
      name: 'settingsPageLocationPermission',
      desc: '',
      args: [],
    );
  }

  /// `Location permission granted`
  String get settingsPageLocationPermissionGranted {
    return Intl.message(
      'Location permission granted',
      name: 'settingsPageLocationPermissionGranted',
      desc: '',
      args: [],
    );
  }

  /// `Location permission denied`
  String get settingsPageLocationPermissionDenied {
    return Intl.message(
      'Location permission denied',
      name: 'settingsPageLocationPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `To change location permissions, go to system settings`
  String get settingsPageLocationPermissionInfo {
    return Intl.message(
      'To change location permissions, go to system settings',
      name: 'settingsPageLocationPermissionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get authLoginTitle {
    return Intl.message(
      'Log in',
      name: 'authLoginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get authRegisterTitle {
    return Intl.message(
      'Create account',
      name: 'authRegisterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get authEmailLabel {
    return Intl.message(
      'Email',
      name: 'authEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authPasswordLabel {
    return Intl.message(
      'Password',
      name: 'authPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get authLoginButton {
    return Intl.message(
      'Log in',
      name: 'authLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get authRegisterButton {
    return Intl.message(
      'Register',
      name: 'authRegisterButton',
      desc: '',
      args: [],
    );
  }

  /// `Need an account? Register`
  String get authGoToRegister {
    return Intl.message(
      'Need an account? Register',
      name: 'authGoToRegister',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Log in`
  String get authGoToLogin {
    return Intl.message(
      'Already have an account? Log in',
      name: 'authGoToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Try again.`
  String get authErrorGeneric {
    return Intl.message(
      'Something went wrong. Try again.',
      name: 'authErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get mainNavHome {
    return Intl.message(
      'Home',
      name: 'mainNavHome',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get mainNavSearch {
    return Intl.message(
      'Search',
      name: 'mainNavSearch',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get mainNavSettings {
    return Intl.message(
      'Settings',
      name: 'mainNavSettings',
      desc: '',
      args: [],
    );
  }

  /// `City search will be available here.`
  String get searchPagePlaceholder {
    return Intl.message(
      'City search will be available here.',
      name: 'searchPagePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get splashPageWelcomeTitle {
    return Intl.message(
      'Welcome!',
      name: 'splashPageWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check the weather in your city, anywhere in the world.`
  String get splashPageWelcomeDescription {
    return Intl.message(
      'Check the weather in your city, anywhere in the world.',
      name: 'splashPageWelcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get splashPageSignInButtonTitle {
    return Intl.message(
      'Sign in',
      name: 'splashPageSignInButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign up`
  String get splashPageDontHaveAccountTitle {
    return Intl.message(
      'Don\'t have an account? Sign up',
      name: 'splashPageDontHaveAccountTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
