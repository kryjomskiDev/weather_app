class Envs {
  const Envs();

  /// Base URL for the Weather API.
  String get apiUrl => const String.fromEnvironment('BASE_API_URL');

  /// OpenWeatherMap API key.
  String get apiKey => const String.fromEnvironment('API_KEY');
}
