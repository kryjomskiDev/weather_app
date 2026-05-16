import 'package:equatable/equatable.dart';

sealed class MainSessionState extends Equatable {
  const MainSessionState();

  @override
  List<Object?> get props => <Object?>[];
}

class MainSessionStateLoaded extends MainSessionState {
  const MainSessionStateLoaded();
}

class MainSessionStateLoading extends MainSessionState {
  const MainSessionStateLoading();
}
