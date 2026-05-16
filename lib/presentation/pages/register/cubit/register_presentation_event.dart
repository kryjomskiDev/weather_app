import 'package:equatable/equatable.dart';

sealed class RegisterPresentationEvent extends Equatable {
  const RegisterPresentationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class RegisterNavigateHomeEvent extends RegisterPresentationEvent {
  const RegisterNavigateHomeEvent();
}

class RegisterShowAuthErrorSnackBarEvent extends RegisterPresentationEvent {
  const RegisterShowAuthErrorSnackBarEvent();
}
