import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/auth/use_case/sign_out_use_case.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/locale/use_case/save_language_code_use_case.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_presentation_event.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_state.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class SettingsCubit extends SafetyCubit<SettingsState>
    with BlocPresentationMixin<SettingsState, SettingsPresentationEvent> {
  final SignOutUseCase _signOutUseCase;
  final GetSelectedLanguageCodeUseCase _getSelectedLanguageCodeUseCase;
  final SaveLanguageCodeUseCase _saveLanguageCodeUseCase;

  SettingsCubit(
    this._signOutUseCase,
    this._getSelectedLanguageCodeUseCase,
    this._saveLanguageCodeUseCase,
  ) : super(const SettingsStateLoading());

  late String _selectedLanguageCode;

  Future<void> init() async {
    emit(const SettingsStateLoading());
    _selectedLanguageCode = _getSelectedLanguageCodeUseCase();
    emit(SettingsStateLoaded(selectedLanguageCode: _selectedLanguageCode));
  }

  Future<void> selectLanguage(String languageCode) async {
    emit(const SettingsStateLoading());

    final Either<GenericError, void> result = await _saveLanguageCodeUseCase(languageCode);

    result.fold(
      (_) => emit(const SettingsStateError()),
      (_) {
        _selectedLanguageCode = languageCode;
        emitPresentation(const LanguageSelectedEvent());
      },
    );
  }

  void onLanguageSelected() => emit(SettingsStateLoaded(selectedLanguageCode: _selectedLanguageCode));

  Future<void> logout() async {
    final Either<GenericError, void> result = await _signOutUseCase();

    result.fold(
      (GenericError error) => emitPresentation(const LogoutFailedEvent()),
      (_) {},
    );
  }
}
