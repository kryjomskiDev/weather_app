import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => <Object?>[];
}

class HomeStateLoading extends HomeState {
  final CurrentWeather? currentWeather;

  const HomeStateLoading({this.currentWeather});

  @override
  List<Object?> get props => <Object?>[currentWeather];
}

class HomeStateLoaded extends HomeState {
  final CurrentWeather currentWeather;

  const HomeStateLoaded({required this.currentWeather});

  @override
  List<Object?> get props => <Object?>[currentWeather];
}

class HomeStateError extends HomeState {
  final GenericError error;

  const HomeStateError({required this.error});

  @override
  List<Object?> get props => <Object?>[error];
}
