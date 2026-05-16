import 'package:equatable/equatable.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => <Object?>[];
}

class RegisterStateLoaded extends RegisterState {
  const RegisterStateLoaded();
}

class RegisterStateSubmitting extends RegisterState {
  const RegisterStateSubmitting();
}
