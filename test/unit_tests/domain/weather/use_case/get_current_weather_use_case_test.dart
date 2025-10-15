import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_use_case.dart';

import 'get_current_weather_use_case_test.mocks.dart';

@GenerateMocks([WeatherService])
void main() {
  late WeatherService weatherService;
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  setUp(() {
    weatherService = MockWeatherService();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(weatherService);
  });

  group('GetCurrentWeatherUseCase', () {
    const lat = 1.0;
    const lon = 1.0;
    const languageCode = 'en';

    test('invokes getCurrentWeather method in WeatherService once', () async {
      when(weatherService.getCurrentWeather(
        latitude: lat,
        longitude: lon,
        languageCode: languageCode,
      )).thenAnswer(
        (_) async => const CurrentWeather(
          title: 'title',
          description: 'description',
          temperature: 10.0,
          icon: 'icon',
          locationName: 'locationName',
        ),
      );

      await getCurrentWeatherUseCase(
        latitude: lat,
        longitude: lon,
        languageCode: languageCode,
      );

      verify(weatherService.getCurrentWeather(
        latitude: lat,
        longitude: lon,
        languageCode: languageCode,
      )).called(1);
    });
  });
}
