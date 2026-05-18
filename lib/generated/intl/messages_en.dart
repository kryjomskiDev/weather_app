// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(action) => "${action}, loading";

  static String m1(location, temperature, condition, description) =>
      "${location}, ${temperature}, ${condition}, ${description}";

  static String m2(language, selectionState) =>
      "${language}, ${selectionState}";

  static String m3(condition) => "${condition} weather icon";

  static String m4(temperature) => "${temperature}°C";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "a11yButtonLoading": m0,
        "a11yCurrentWeatherSummary": m1,
        "a11yHidePassword":
            MessageLookupByLibrary.simpleMessage("Hide password"),
        "a11yLanguageOption": m2,
        "a11yLoading": MessageLookupByLibrary.simpleMessage("Loading"),
        "a11yNotSelected": MessageLookupByLibrary.simpleMessage("not selected"),
        "a11ySearchSubmit": MessageLookupByLibrary.simpleMessage("Search"),
        "a11ySelected": MessageLookupByLibrary.simpleMessage("selected"),
        "a11yShowPassword":
            MessageLookupByLibrary.simpleMessage("Show password"),
        "a11yWeatherIcon": m3,
        "authEmailLabel": MessageLookupByLibrary.simpleMessage("Email"),
        "authErrorGeneric": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Try again."),
        "authGoToLogin": MessageLookupByLibrary.simpleMessage(
            "Already have an account? Log in"),
        "authGoToRegister":
            MessageLookupByLibrary.simpleMessage("Need an account? Register"),
        "authLoginButton": MessageLookupByLibrary.simpleMessage("Log in"),
        "authLoginTitle": MessageLookupByLibrary.simpleMessage("Log in"),
        "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "authRegisterButton": MessageLookupByLibrary.simpleMessage("Register"),
        "authRegisterTitle":
            MessageLookupByLibrary.simpleMessage("Create account"),
        "homePageErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Something went wrong, please try again"),
        "homePageLocationDisabledTitle": MessageLookupByLibrary.simpleMessage(
            "Location is disabled, enable it to continue"),
        "homePageLocationPermissionDeniedTitle":
            MessageLookupByLibrary.simpleMessage(
                "Location permission is denied, grant it in system settings"),
        "homePageRefreshButtonTitle":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "homePageSettingsButtonTitle":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "homePageTemperature": m4,
        "mainNavHome": MessageLookupByLibrary.simpleMessage("Home"),
        "mainNavSearch": MessageLookupByLibrary.simpleMessage("Search"),
        "mainNavSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "searchPageCityNotFound": MessageLookupByLibrary.simpleMessage(
            "City not found. Try a different name."),
        "searchPageEmptyMessage": MessageLookupByLibrary.simpleMessage(
            "Search for a city to see the current weather."),
        "searchPageErrorGeneric": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Please try again."),
        "searchPageHint": MessageLookupByLibrary.simpleMessage("City name"),
        "searchPageTryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
        "settingsPageCloseButtonTitle":
            MessageLookupByLibrary.simpleMessage("Close"),
        "settingsPageLanguage":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settingsPageLanguageEnglish":
            MessageLookupByLibrary.simpleMessage("English"),
        "settingsPageLanguagePolish":
            MessageLookupByLibrary.simpleMessage("Polish"),
        "settingsPageLocationPermission":
            MessageLookupByLibrary.simpleMessage("Location permission"),
        "settingsPageLocationPermissionDenied":
            MessageLookupByLibrary.simpleMessage("Location permission denied"),
        "settingsPageLocationPermissionGranted":
            MessageLookupByLibrary.simpleMessage("Location permission granted"),
        "settingsPageLocationPermissionInfo":
            MessageLookupByLibrary.simpleMessage(
                "To change location permissions, go to system settings"),
        "settingsPageLogoutTitle":
            MessageLookupByLibrary.simpleMessage("Log out"),
        "splashPageDontHaveAccountTitle": MessageLookupByLibrary.simpleMessage(
            "Don\'t have an account? Sign up"),
        "splashPageSignInButtonTitle":
            MessageLookupByLibrary.simpleMessage("Sign in"),
        "splashPageWelcomeDescription": MessageLookupByLibrary.simpleMessage(
            "Check the weather in your city, anywhere in the world."),
        "splashPageWelcomeTitle":
            MessageLookupByLibrary.simpleMessage("Welcome!")
      };
}
