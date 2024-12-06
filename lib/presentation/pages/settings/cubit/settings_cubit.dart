import 'package:fimber_io/fimber_io.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/locale/use_case/get_selected_language_code_use_case.dart';
import 'package:weather_app/domain/locale/use_case/save_language_code_use_case.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';
import 'package:weather_app/presentation/pages/settings/cubit/settings_state.dart';
import 'package:weather_app/utils/l10n_model.dart';
import 'package:weather_app/utils/safety_cubit.dart';

@injectable
class SettingsCubit extends SafetyCubit<SettingsState> {
  final GetSelectedLanguageCodeUseCase _getSelectedLanguageCodeUseCase;
  final SaveLanguageCodeUseCase _saveLanguageCodeUseCase;
  final CheckLocationPermissionStatusUseCase _checkLocationPermissionStatusUseCase;

  SettingsCubit(
    this._getSelectedLanguageCodeUseCase,
    this._saveLanguageCodeUseCase,
    this._checkLocationPermissionStatusUseCase,
  ) : super(const SettingsState.idle());

  late String _selectedLangaugeCode;
  late LocationPermissionStatus _locationPermissionStatus;

  Future<void> init() async {
    try {
      emit(const SettingsState.loading());
      _selectedLangaugeCode = _getSelectedLanguageCodeUseCase() ?? englishLanguageCode;
      _locationPermissionStatus = await _checkLocationPermissionStatusUseCase();

      emit(SettingsState.loaded(
        selectedLanguageCode: _selectedLangaugeCode,
        locationPermissionStatus: _locationPermissionStatus,
      ));
    } catch (error, st) {
      Fimber.e('Error while initializing settings', ex: error, stacktrace: st);
      emit(const SettingsState.error());
    }
  }

  Future<void> selectLangauge(String languageCode) async {
    try {
      emit(const SettingsState.loading());

      _selectedLangaugeCode = languageCode;
      await _saveLanguageCodeUseCase(languageCode);

      emit(const SettingsState.languageSelected());
    } catch (error, st) {
      Fimber.e('Error while selecting language', ex: error, stacktrace: st);
      emit(const SettingsState.error());
    }
  }

  void onLanguageSelected() => emit(SettingsState.loaded(
        selectedLanguageCode: _selectedLangaugeCode,
        locationPermissionStatus: _locationPermissionStatus,
      ));

  void closePage() {
    emit(const SettingsState.idle());
    emit(const SettingsState.closePage());
  }
}
