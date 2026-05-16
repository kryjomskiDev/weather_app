import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_presentation_event.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_state.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class SplashCubit extends SafetyCubit<SplashState> with BlocPresentationMixin<SplashState, SplashPresentationEvent> {
  SplashCubit() : super(const SplashStateLoaded());

  void navigateToLogin() => emitPresentation(const SplashNavigateToLoginEvent());

  void navigateToRegister() => emitPresentation(const SplashNavigateToRegisterEvent());
}
