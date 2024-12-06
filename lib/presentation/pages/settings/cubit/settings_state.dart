import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';

sealed class SettingsState with EquatableMixin {
  const SettingsState();

  const factory SettingsState.idle() = SettingsStateIdle;

  const factory SettingsState.loading() = SettingsStateLoading;

  const factory SettingsState.loaded({
    required String selectedLanguageCode,
    required LocationPermissionStatus locationPermissionStatus,
  }) = SettingsStateLoaded;

  const factory SettingsState.error() = SettingsStateError;

  const factory SettingsState.closePage() = SettingsStateClosePage;

  const factory SettingsState.languageSelected() = SettingsStateLanguageSelected;

  @override
  List<Object?> get props => [];
}

abstract class SettingsStateBuilder {}

abstract class SettingsStateListener {}

class SettingsStateIdle extends SettingsState {
  const SettingsStateIdle();
}

class SettingsStateLoading extends SettingsState implements SettingsStateBuilder {
  const SettingsStateLoading();
}

class SettingsStateLoaded extends SettingsState implements SettingsStateBuilder {
  final String selectedLanguageCode;
  final LocationPermissionStatus locationPermissionStatus;

  const SettingsStateLoaded({
    required this.selectedLanguageCode,
    required this.locationPermissionStatus,
  });

  @override
  List<Object?> get props => [selectedLanguageCode, locationPermissionStatus];
}

class SettingsStateError extends SettingsState implements SettingsStateBuilder {
  const SettingsStateError();
}

class SettingsStateClosePage extends SettingsState implements SettingsStateListener {
  const SettingsStateClosePage();
}

class SettingsStateLanguageSelected extends SettingsState implements SettingsStateListener {
  const SettingsStateLanguageSelected();
}
