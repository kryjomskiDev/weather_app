import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => <Object?>[];
}

class SearchStateInitial extends SearchState {
  const SearchStateInitial();
}

class SearchStateLoading extends SearchState {
  const SearchStateLoading();
}

class SearchStateLoaded extends SearchState {
  final CurrentWeather currentWeather;

  const SearchStateLoaded({required this.currentWeather});

  @override
  List<Object?> get props => <Object?>[currentWeather];
}

class SearchStateError extends SearchState {
  final GenericError error;

  const SearchStateError({required this.error});

  @override
  List<Object?> get props => <Object?>[error];
}
