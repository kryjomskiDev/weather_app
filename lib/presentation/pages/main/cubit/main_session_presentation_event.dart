import 'package:equatable/equatable.dart';

sealed class MainSessionPresentationEvent extends Equatable {
  const MainSessionPresentationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class MainSessionExpiredEvent extends MainSessionPresentationEvent {
  const MainSessionExpiredEvent();
}
