import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/model/auth_user.dart';
import 'package:weather_app/domain/auth/use_case/register_with_email_and_password_use_case.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_presentation_event.dart';
import 'package:weather_app/presentation/pages/register/cubit/register_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class RegisterCubit extends SafetyCubit<RegisterState>
    with BlocPresentationMixin<RegisterState, RegisterPresentationEvent> {
  final RegisterWithEmailAndPasswordUseCase _registerWithEmailAndPasswordUseCase;

  RegisterCubit(this._registerWithEmailAndPasswordUseCase) : super(const RegisterStateLoaded());

  Future<void> register({required String email, required String password}) async {
    emit(const RegisterStateSubmitting());

    final Either<GenericError, AuthUser> result = await _registerWithEmailAndPasswordUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (_) {
        emitPresentation(const RegisterShowAuthErrorSnackBarEvent());
        emit(const RegisterStateLoaded());
      },
      (_) {
        emit(const RegisterStateLoaded());
        emitPresentation(const RegisterNavigateHomeEvent());
      },
    );
  }
}
