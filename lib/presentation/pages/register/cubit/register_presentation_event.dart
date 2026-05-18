import 'package:equatable/equatable.dart';

sealed class RegisterPresentationEvent extends Equatable {
  const RegisterPresentationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class RegisterShowAuthErrorSnackBarEvent extends RegisterPresentationEvent {
  const RegisterShowAuthErrorSnackBarEvent();
}
