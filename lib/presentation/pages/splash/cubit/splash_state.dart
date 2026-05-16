import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => <Object?>[];
}

class SplashStateLoading extends SplashState {
  const SplashStateLoading();
}

class SplashStateLoaded extends SplashState {
  const SplashStateLoaded();
}
