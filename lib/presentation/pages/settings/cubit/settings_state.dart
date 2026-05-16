import 'package:equatable/equatable.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => <Object?>[];
}

class SettingsStateLoading extends SettingsState {
  const SettingsStateLoading();
}

class SettingsStateLoaded extends SettingsState {
  final String selectedLanguageCode;

  const SettingsStateLoaded({required this.selectedLanguageCode});

  @override
  List<Object?> get props => <Object?>[selectedLanguageCode];
}

class SettingsStateError extends SettingsState {
  const SettingsStateError();
}
