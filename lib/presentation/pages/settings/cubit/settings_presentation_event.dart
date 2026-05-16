import 'package:equatable/equatable.dart';

sealed class SettingsPresentationEvent extends Equatable {
  const SettingsPresentationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LogoutFailedEvent extends SettingsPresentationEvent {
  const LogoutFailedEvent();
}

class LanguageSelectedEvent extends SettingsPresentationEvent {
  const LanguageSelectedEvent();
}
