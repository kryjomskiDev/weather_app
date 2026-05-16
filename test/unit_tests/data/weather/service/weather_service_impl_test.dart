import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/weather/data_source/weather_api_data_source.dart';
import 'package:weather_app/data/weather/model/weather_details_dto.dart';
import 'package:weather_app/data/weather/model/weather_dto.dart';
import 'package:weather_app/data/weather/model/weather_temp_info_dto.dart';
import 'package:weather_app/data/weather/service/weather_service_impl.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/service/weather_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

import 'weather_service_impl_test.mocks.dart';

@GenerateMocks(<Type>[WeatherApiDataSource])
void main() {
  late WeatherApiDataSource weatherApiDataSource;
  late WeatherService weatherService;

  setUp(() {
    weatherApiDataSource = MockWeatherApiDataSource();
    weatherService = WeatherServiceImpl(weatherApiDataSource);
  });

  group('WeatherService', () {
    const double latitude = 30.0;
    const double longitude = 40.0;
    const String languageCode = 'en';

    group('getCurrentWeather method', () {
      test('returns CurrentWeather successfully', () async {
        const WeatherDto dto = WeatherDto(
          'London',
          <WeatherDetailsDto>[WeatherDetailsDto('Clear', 'clear sky', '01d')],
          WeatherTempInfoDto(26.1),
        );

        const CurrentWeather expectedAnswer = CurrentWeather(
          locationName: 'London',
          description: 'clear sky',
          icon: '01d',
          temperature: 26.1,
          title: 'Clear',
        );

        when(
          weatherApiDataSource.getWeatherByCords(
            latitude,
            longitude,
            languageCode,
          ),
        ).thenAnswer((_) async => dto);

        final Either<GenericError, CurrentWeather> result = await weatherService.getCurrentWeather(
          latitude: latitude,
          longitude: longitude,
          languageCode: languageCode,
        );

        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(expectedAnswer), equals(expectedAnswer));
        verify(
          weatherApiDataSource.getWeatherByCords(
            latitude,
            longitude,
            languageCode,
          ),
        ).called(1);
      });

      test('returns Failure when data source fails', () async {
        when(
          weatherApiDataSource.getWeatherByCords(
            latitude,
            longitude,
            languageCode,
          ),
        ).thenThrow(Exception());

        final Either<GenericError, CurrentWeather> result = await weatherService.getCurrentWeather(
          latitude: latitude,
          longitude: longitude,
          languageCode: languageCode,
        );

        expect(result.isFailure(), isTrue);

        verify(
          weatherApiDataSource.getWeatherByCords(
            latitude,
            longitude,
            languageCode,
          ),
        ).called(1);
      });
    });
  });
}
