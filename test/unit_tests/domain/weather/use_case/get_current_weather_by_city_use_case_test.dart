import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_by_city_use_case.dart';
import 'package:weather_app/utils/error_handling/either.dart';

import 'get_current_weather_by_city_use_case_test.mocks.dart';

@GenerateMocks(<Type>[WeatherService])
void main() {
  late WeatherService weatherService;
  late GetCurrentWeatherByCityUseCase getCurrentWeatherByCityUseCase;

  setUp(() {
    weatherService = MockWeatherService();
    getCurrentWeatherByCityUseCase = GetCurrentWeatherByCityUseCase(weatherService);
  });

  group('GetCurrentWeatherByCityUseCase', () {
    const String city = 'London';
    const String languageCode = 'en';

    test('invokes getCurrentWeatherByCity method in WeatherService once', () async {
      when(
        weatherService.getCurrentWeatherByCity(
          city: city,
          languageCode: languageCode,
        ),
      ).thenAnswer(
        (_) async => Either.success(
          const CurrentWeather(
            title: 'title',
            description: 'description',
            temperature: 10.0,
            icon: 'icon',
            locationName: 'locationName',
          ),
        ),
      );

      await getCurrentWeatherByCityUseCase(
        city: city,
        languageCode: languageCode,
      );

      verify(
        weatherService.getCurrentWeatherByCity(
          city: city,
          languageCode: languageCode,
        ),
      ).called(1);
    });
  });
}
