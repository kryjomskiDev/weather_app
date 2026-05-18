import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/sign_in_with_email_and_password_use_case.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_presentation_event.dart';
import 'package:weather_app/presentation/pages/login/cubit/login_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class LoginCubit extends SafetyCubit<LoginState> with BlocPresentationMixin<LoginState, LoginPresentationEvent> {
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;

  LoginCubit(this._signInWithEmailAndPasswordUseCase) : super(const LoginStateLoaded());

  Future<void> signIn({required String email, required String password}) async {
    emit(const LoginStateSubmitting());

    final Either<GenericError, AuthUser> result = await _signInWithEmailAndPasswordUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (_) {
        emitPresentation(const LoginShowAuthErrorSnackBarEvent());
        emit(const LoginStateLoaded());
      },
      (_) {
        /// Session expiration checker will handle the navigation
        emit(const LoginStateLoaded());
      },
    );
  }
}
