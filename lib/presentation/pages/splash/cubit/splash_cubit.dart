import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/get_current_auth_user_use_case.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_presentation_event.dart';
import 'package:weather_app/presentation/pages/splash/cubit/splash_state.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class SplashCubit extends SafetyCubit<SplashState> with BlocPresentationMixin<SplashState, SplashPresentationEvent> {
  final GetCurrentAuthUserUseCase _getCurrentAuthUserUseCase;

  SplashCubit(this._getCurrentAuthUserUseCase) : super(const SplashStateLoading());

  void init() {
    final AuthUser? user = _getCurrentAuthUserUseCase();
    if (user != null) {
      emitPresentation(const SplashNavigateToHomeEvent());
    } else {
      emit(const SplashStateLoaded());
    }
  }

  void navigateToLogin() => emitPresentation(const SplashNavigateToLoginEvent());

  void navigateToRegister() => emitPresentation(const SplashNavigateToRegisterEvent());
}
