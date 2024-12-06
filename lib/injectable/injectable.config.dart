// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../data/locale/data_source/locale_data_source.dart' as _i945;
import '../data/locale/store/locale_store_impl.dart' as _i634;
import '../data/location/data_source/location_data_source.dart' as _i479;
import '../data/location/service/location_service_impl.dart' as _i677;
import '../data/weather/data_source/weather_api_data_source.dart' as _i670;
import '../data/weather/service/weather_service_impl.dart' as _i178;
import '../domain/env/get_api_url_use_case.dart' as _i35;
import '../domain/locale/store/locale_store.dart' as _i441;
import '../domain/locale/use_case/get_selected_language_code_use_case.dart'
    as _i80;
import '../domain/locale/use_case/save_language_code_use_case.dart' as _i548;
import '../domain/location/service/location_service.dart' as _i690;
import '../domain/location/use_case/check_location_permission_status_use_case.dart'
    as _i164;
import '../domain/location/use_case/get_current_location_use_case.dart'
    as _i899;
import '../domain/location/use_case/is_location_service_enabled_use_case.dart'
    as _i299;
import '../domain/location/use_case/request_location_permission_use_case.dart'
    as _i226;
import '../domain/weather/service/weather_service.dart' as _i743;
import '../domain/weather/use_case/get_current_weather_use_case.dart' as _i464;
import '../presentation/pages/home/cubit/home_cubit.dart' as _i852;
import '../presentation/pages/settings/cubit/settings_cubit.dart' as _i427;
import 'dio_injectable/dio_injectable.dart' as _i984;
import 'shared_preferences_injectable.dart' as _i479;

const String _dev = 'dev';
const String _staging = 'staging';
const String _test = 'test';
const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final sharedPreferencesModule = _$SharedPreferencesModule();
  final dioModule = _$DioModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => sharedPreferencesModule.sharedPreferences,
    preResolve: true,
  );
  gh.singleton<_i479.LocationDataSource>(() => _i479.LocationDataSource());
  gh.factory<_i35.GetApiUrlUseCase>(
    () => _i35.DevGetApiUrlUseCase(),
    registerFor: {_dev},
  );
  gh.factory<_i35.GetApiUrlUseCase>(
    () => _i35.StagingGetApiUrlUseCase(),
    registerFor: {_staging},
  );
  gh.lazySingleton<_i690.LocationService>(
      () => _i677.LocationServiceImpl(gh<_i479.LocationDataSource>()));
  gh.singleton<_i361.Dio>(
    () => dioModule.testDio(),
    registerFor: {_test},
  );
  gh.lazySingleton<_i361.Dio>(
    () => dioModule.dio(gh<_i35.GetApiUrlUseCase>()),
    registerFor: {
      _dev,
      _prod,
      _staging,
    },
  );
  gh.factory<_i35.GetApiUrlUseCase>(
    () => _i35.ProdGetApiUrlUseCase(),
    registerFor: {_prod},
  );
  gh.factory<_i945.LocaleDataSource>(
      () => _i945.LocaleDataSource(gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i441.LocaleStore>(
      () => _i634.LocaleStoreImpl(gh<_i945.LocaleDataSource>()));
  gh.factory<_i80.GetSelectedLanguageCodeUseCase>(
      () => _i80.GetSelectedLanguageCodeUseCase(gh<_i441.LocaleStore>()));
  gh.factory<_i226.RequestLocationPermissionUseCase>(() =>
      _i226.RequestLocationPermissionUseCase(gh<_i690.LocationService>()));
  gh.factory<_i299.IsLocationServiceEnabledUseCase>(
      () => _i299.IsLocationServiceEnabledUseCase(gh<_i690.LocationService>()));
  gh.factory<_i164.CheckLocationPermissionStatusUseCase>(() =>
      _i164.CheckLocationPermissionStatusUseCase(gh<_i690.LocationService>()));
  gh.factory<_i899.GetCurrentLocationUseCase>(
      () => _i899.GetCurrentLocationUseCase(gh<_i690.LocationService>()));
  gh.factory<_i670.WeatherApiDataSource>(
      () => _i670.WeatherApiDataSource(gh<_i361.Dio>()));
  gh.lazySingleton<_i743.WeatherService>(
      () => _i178.WeatherServiceImpl(gh<_i670.WeatherApiDataSource>()));
  gh.factory<_i464.GetCurrentWeatherUseCase>(
      () => _i464.GetCurrentWeatherUseCase(gh<_i743.WeatherService>()));
  gh.factory<_i548.SaveLanguageCodeUseCase>(
      () => _i548.SaveLanguageCodeUseCase(gh<_i441.LocaleStore>()));
  gh.factory<_i852.HomeCubit>(() => _i852.HomeCubit(
        gh<_i464.GetCurrentWeatherUseCase>(),
        gh<_i80.GetSelectedLanguageCodeUseCase>(),
        gh<_i299.IsLocationServiceEnabledUseCase>(),
        gh<_i164.CheckLocationPermissionStatusUseCase>(),
        gh<_i226.RequestLocationPermissionUseCase>(),
        gh<_i899.GetCurrentLocationUseCase>(),
      ));
  gh.factory<_i427.SettingsCubit>(() => _i427.SettingsCubit(
        gh<_i80.GetSelectedLanguageCodeUseCase>(),
        gh<_i548.SaveLanguageCodeUseCase>(),
        gh<_i164.CheckLocationPermissionStatusUseCase>(),
      ));
  return getIt;
}

class _$SharedPreferencesModule extends _i479.SharedPreferencesModule {}

class _$DioModule extends _i984.DioModule {}
