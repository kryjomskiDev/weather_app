abstract interface class LocaleStore {
  String? getSelectedLanguageCode();

  Future<void> saveLanguageCode(String languageCode);
}
