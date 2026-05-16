import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginStateLoaded extends LoginState {
  const LoginStateLoaded();
}

class LoginStateSubmitting extends LoginState {
  const LoginStateSubmitting();
}
