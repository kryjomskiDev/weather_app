import 'package:equatable/equatable.dart';

sealed class LoginPresentationEvent extends Equatable {
  const LoginPresentationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginShowAuthErrorSnackBarEvent extends LoginPresentationEvent {
  const LoginShowAuthErrorSnackBarEvent();
}
