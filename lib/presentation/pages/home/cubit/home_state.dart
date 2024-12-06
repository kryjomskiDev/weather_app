import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/weather/model/current_weather.dart';

sealed class HomeState with EquatableMixin {
  const HomeState();

  const factory HomeState.idle() = HomeStateIdle;

  const factory HomeState.loading() = HomeStateLoading;

  const factory HomeState.loaded({required CurrentWeather currentWeather}) = HomeStateLoaded;

  const factory HomeState.refreshPage({required CurrentWeather currentWeather}) = HomeStateRefreshPage;

  const factory HomeState.error() = HomeStateError;

  const factory HomeState.goToSettings() = HomeStateGoToSettings;

  const factory HomeState.locationDisabled() = HomeStateLocationDisabled;

  const factory HomeState.locationPermissionDenied() = HomeStateLocationPermissionDenied;

  @override
  List<Object?> get props => [];
}

abstract class HomeStateBuilder {}

abstract class HomeStateListener {}

class HomeStateIdle extends HomeState {
  const HomeStateIdle();
}

class HomeStateLoading extends HomeState implements HomeStateBuilder {
  const HomeStateLoading();
}

class HomeStateLoaded extends HomeState implements HomeStateBuilder {
  final CurrentWeather currentWeather;

  const HomeStateLoaded({required this.currentWeather});

  @override
  List<Object?> get props => [currentWeather];
}

class HomeStateRefreshPage extends HomeState implements HomeStateBuilder {
  final CurrentWeather currentWeather;

  const HomeStateRefreshPage({required this.currentWeather});

  @override
  List<Object?> get props => [currentWeather];
}

class HomeStateError extends HomeState implements HomeStateBuilder {
  const HomeStateError();
}

class HomeStateGoToSettings extends HomeState implements HomeStateListener {
  const HomeStateGoToSettings();
}

class HomeStateLocationDisabled extends HomeState implements HomeStateBuilder {
  const HomeStateLocationDisabled();
}

class HomeStateLocationPermissionDenied extends HomeState implements HomeStateBuilder {
  const HomeStateLocationPermissionDenied();
}
