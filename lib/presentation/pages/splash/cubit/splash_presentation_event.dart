import 'package:equatable/equatable.dart';

sealed class SplashPresentationEvent extends Equatable {
  const SplashPresentationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class SplashNavigateToLoginEvent extends SplashPresentationEvent {
  const SplashNavigateToLoginEvent();
}

class SplashNavigateToRegisterEvent extends SplashPresentationEvent {
  const SplashNavigateToRegisterEvent();
}
