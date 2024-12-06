enum WeatherAppRoutes {
  home('/home'),
  settings('settings');

  const WeatherAppRoutes(this.path);

  final String path;
}
