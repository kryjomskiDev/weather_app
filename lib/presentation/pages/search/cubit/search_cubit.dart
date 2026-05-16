import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/domain/weather/use_case/get_current_weather_by_city_use_case.dart';
import 'package:weather_app/presentation/pages/search/cubit/search_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class SearchCubit extends SafetyCubit<SearchState> {
  final GetCurrentWeatherByCityUseCase _getCurrentWeatherByCityUseCase;
  final GetSelectedLanguageCodeUseCase _getSelectedLanguageCodeUseCase;

  SearchCubit(
    this._getCurrentWeatherByCityUseCase,
    this._getSelectedLanguageCodeUseCase,
  ) : super(const SearchStateInitial());

  String? _lastQuery;

  Future<void> search(String city) async {
    final String query = city.trim();

    if (query.isEmpty) {
      return;
    }

    _lastQuery = query;
    emit(const SearchStateLoading());

    final String languageCode = _getSelectedLanguageCodeUseCase();
    final Either<GenericError, CurrentWeather> result = await _getCurrentWeatherByCityUseCase(
      city: query,
      languageCode: languageCode,
    );

    result.fold(
      (GenericError error) => emit(SearchStateError(error: error)),
      (CurrentWeather currentWeather) => emit(SearchStateLoaded(currentWeather: currentWeather)),
    );
  }

  Future<void> retry() async {
    final String? lastQuery = _lastQuery;
    if (lastQuery == null) {
      return;
    }

    await search(lastQuery);
  }
}
