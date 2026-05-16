import 'package:equatable/equatable.dart';

sealed class SessionExpirationCheckerState extends Equatable {
  const SessionExpirationCheckerState();

  @override
  List<Object?> get props => <Object?>[];
}

class SessionExpirationCheckerIdleState extends SessionExpirationCheckerState {
  const SessionExpirationCheckerIdleState();
}

class SessionExpirationCheckerUnauthenticatedState extends SessionExpirationCheckerState {
  const SessionExpirationCheckerUnauthenticatedState();
}

class SessionExpirationCheckerAuthenticatedState extends SessionExpirationCheckerState {
  const SessionExpirationCheckerAuthenticatedState();
}
