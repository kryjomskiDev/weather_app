import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_by_city_use_case.dart';
import 'package:weather_app/presentation/pages/search/cubit/search_cubit.dart';
import 'package:weather_app/presentation/pages/search/cubit/search_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/http_errors.dart';

import 'search_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  GetCurrentWeatherByCityUseCase,
  GetSelectedLanguageCodeUseCase,
])
void main() {
  late GetCurrentWeatherByCityUseCase getCurrentWeatherByCityUseCase;
  late GetSelectedLanguageCodeUseCase getSelectedLanguageCodeUseCase;
  late SearchCubit searchCubit;

  const CurrentWeather currentWeather = CurrentWeather(
    title: 'Clear',
    description: 'clear sky',
    temperature: 20.0,
    icon: '01d',
    locationName: 'London',
  );

  setUp(() {
    getCurrentWeatherByCityUseCase = MockGetCurrentWeatherByCityUseCase();
    getSelectedLanguageCodeUseCase = MockGetSelectedLanguageCodeUseCase();

    searchCubit = SearchCubit(
      getCurrentWeatherByCityUseCase,
      getSelectedLanguageCodeUseCase,
    );

    when(getSelectedLanguageCodeUseCase()).thenReturn('en');
  });

  group('SearchCubit', () {
    test('has initial state', () => expect(searchCubit.state, const SearchStateInitial()));

    blocTest<SearchCubit, SearchState>(
      'emits loading then loaded when search succeeds',
      build: () {
        when(
          getCurrentWeatherByCityUseCase(
            city: 'London',
            languageCode: 'en',
          ),
        ).thenAnswer((_) async => Either.success(currentWeather));

        return searchCubit;
      },
      act: (SearchCubit cubit) => cubit.search('London'),
      expect: () => <SearchState>[
        const SearchStateLoading(),
        const SearchStateLoaded(currentWeather: currentWeather),
      ],
    );

    blocTest<SearchCubit, SearchState>(
      'emits loading then error when search fails',
      build: () {
        when(
          getCurrentWeatherByCityUseCase(
            city: 'Unknown',
            languageCode: 'en',
          ),
        ).thenAnswer((_) async => Either.failure(const NotFoundError()));

        return searchCubit;
      },
      act: (SearchCubit cubit) => cubit.search('Unknown'),
      expect: () => <SearchState>[
        const SearchStateLoading(),
        const SearchStateError(error: NotFoundError()),
      ],
    );

    blocTest<SearchCubit, SearchState>(
      'does not emit when search query is empty',
      build: () => searchCubit,
      act: (SearchCubit cubit) => cubit.search('   '),
      expect: () => <SearchState>[],
    );

    blocTest<SearchCubit, SearchState>(
      'retry re-runs last search query',
      build: () {
        when(
          getCurrentWeatherByCityUseCase(
            city: 'London',
            languageCode: 'en',
          ),
        ).thenAnswer((_) async => Either.success(currentWeather));

        return searchCubit;
      },
      act: (SearchCubit cubit) async {
        await cubit.search('London');
        await cubit.retry();
      },
      expect: () => <SearchState>[
        const SearchStateLoading(),
        const SearchStateLoaded(currentWeather: currentWeather),
        const SearchStateLoading(),
        const SearchStateLoaded(currentWeather: currentWeather),
      ],
    );
  });
}
