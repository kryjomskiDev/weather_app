// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  static String m0(temperature) => "${temperature}°C";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "homePageErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Coś poszło nie tak, spróbuj ponownie"),
        "homePageLocationDisabledTitle": MessageLookupByLibrary.simpleMessage(
            "Lokalizacja jest wyłączona, włącz ją, aby kontynuować"),
        "homePageLocationPermissionDeniedTitle":
            MessageLookupByLibrary.simpleMessage(
                "Odmowa uprawnień lokalizacji, nadaj je w ustawieniach systemowych"),
        "homePageRefreshButtonTitle":
            MessageLookupByLibrary.simpleMessage("Odśwież"),
        "homePageSettingsButtonTitle":
            MessageLookupByLibrary.simpleMessage("Ustawienia"),
        "homePageTemperature": m0,
        "settingsPageCloseButtonTitle":
            MessageLookupByLibrary.simpleMessage("Zamknij"),
        "settingsPageLanguage": MessageLookupByLibrary.simpleMessage("Język"),
        "settingsPageLanguageEnglish":
            MessageLookupByLibrary.simpleMessage("Angielski"),
        "settingsPageLanguagePolish":
            MessageLookupByLibrary.simpleMessage("Polski"),
        "settingsPageLocationPermission":
            MessageLookupByLibrary.simpleMessage("Uprawnienia lokalizacji"),
        "settingsPageLocationPermissionDenied":
            MessageLookupByLibrary.simpleMessage(
                "Uprawnienia lokalizacji odmówione"),
        "settingsPageLocationPermissionGranted":
            MessageLookupByLibrary.simpleMessage(
                "Uprawnienia lokalizacji przyznane"),
        "settingsPageLocationPermissionInfo": MessageLookupByLibrary.simpleMessage(
            "By uzyskać dostęp do lokalizacji, przyznaj uprawnienia w ustawieniach systemowych")
      };
}
