enum WeatherAppRoutes {
  splash('/splash'),
  login('login'),
  register('register'),
  home('/home'),
  search('/search'),
  settings('/settings')
  ;

  const WeatherAppRoutes(this.path);

  final String path;
}
