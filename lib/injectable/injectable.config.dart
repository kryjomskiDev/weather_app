// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../config/envs.dart' as _i1043;
import '../data/auth/data_source/auth_data_source.dart' as _i32;
import '../data/auth/service/auth_service_impl.dart' as _i756;
import '../data/locale/store/locale_store_impl.dart' as _i634;
import '../data/location/data_source/location_data_source.dart' as _i479;
import '../data/location/service/location_service_impl.dart' as _i677;
import '../data/weather/data_source/weather_api_data_source.dart' as _i670;
import '../data/weather/service/weather_service_impl.dart' as _i178;
import '../domain/auth/service/auth_service.dart' as _i368;
import '../domain/auth/use_case/get_current_auth_user_use_case.dart' as _i80;
import '../domain/auth/use_case/register_with_email_and_password_use_case.dart'
    as _i239;
import '../domain/auth/use_case/sign_in_with_email_and_password_use_case.dart'
    as _i56;
import '../domain/auth/use_case/sign_out_use_case.dart' as _i1044;
import '../domain/auth/use_case/subscribe_to_auth_user_changes_use_case.dart'
    as _i924;
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
import '../domain/weather/use_case/get_current_weather_by_city_use_case.dart'
    as _i674;
import '../domain/weather/use_case/get_current_weather_use_case.dart' as _i464;
import '../presentation/pages/home/cubit/home_cubit.dart' as _i852;
import '../presentation/pages/login/cubit/login_cubit.dart' as _i139;
import '../presentation/pages/register/cubit/register_cubit.dart' as _i904;
import '../presentation/pages/search/cubit/search_cubit.dart' as _i799;
import '../presentation/pages/settings/cubit/settings_cubit.dart' as _i427;
import '../presentation/pages/splash/cubit/splash_cubit.dart' as _i386;
import '../presentation/widgets/session_expiration_checker/cubit/session_expiration_checker_cubit.dart'
    as _i948;
import 'dio_injectable/dio_injectable.dart' as _i984;
import 'envs_module.dart' as _i253;
import 'injectable_firebase_auth_module.dart' as _i284;
import 'shared_preferences_module.dart' as _i110;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';
const String _test = 'test';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final sharedPreferencesModule = _$SharedPreferencesModule();
  final injectableFirebaseAuthModule = _$InjectableFirebaseAuthModule();
  final envsModule = _$EnvsModule();
  final dioModule = _$DioModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => sharedPreferencesModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i386.SplashCubit>(() => _i386.SplashCubit());
  gh.singleton<_i479.LocationDataSource>(() => _i479.LocationDataSource());
  gh.lazySingleton<_i59.FirebaseAuth>(
    () => injectableFirebaseAuthModule.firebaseAuth,
  );
  gh.lazySingleton<_i690.LocationService>(
    () => _i677.LocationServiceImpl(gh<_i479.LocationDataSource>()),
  );
  gh.lazySingleton<_i441.LocaleStore>(
    () => _i634.LocaleStoreImpl(gh<_i460.SharedPreferences>()),
  );
  gh.factory<_i164.CheckLocationPermissionStatusUseCase>(
    () =>
        _i164.CheckLocationPermissionStatusUseCase(gh<_i690.LocationService>()),
  );
  gh.factory<_i899.GetCurrentLocationUseCase>(
    () => _i899.GetCurrentLocationUseCase(gh<_i690.LocationService>()),
  );
  gh.factory<_i299.IsLocationServiceEnabledUseCase>(
    () => _i299.IsLocationServiceEnabledUseCase(gh<_i690.LocationService>()),
  );
  gh.factory<_i226.RequestLocationPermissionUseCase>(
    () => _i226.RequestLocationPermissionUseCase(gh<_i690.LocationService>()),
  );
  gh.singleton<_i1043.Envs>(
    () => envsModule.envs,
    registerFor: {_dev, _staging, _prod},
  );
  gh.singleton<_i361.Dio>(() => dioModule.testDio(), registerFor: {_test});
  gh.singleton<_i32.AuthDataSource>(
    () => _i32.AuthDataSource(gh<_i59.FirebaseAuth>()),
  );
  gh.factory<_i548.SaveLanguageCodeUseCase>(
    () => _i548.SaveLanguageCodeUseCase(gh<_i441.LocaleStore>()),
  );
  gh.factory<_i80.GetSelectedLanguageCodeUseCase>(
    () => _i80.GetSelectedLanguageCodeUseCase(gh<_i441.LocaleStore>()),
  );
  gh.lazySingleton<_i361.Dio>(
    () => dioModule.dio(gh<_i1043.Envs>()),
    registerFor: {_dev, _prod, _staging},
  );
  gh.factory<_i670.WeatherApiDataSource>(
    () => _i670.WeatherApiDataSource(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i743.WeatherService>(
    () => _i178.WeatherServiceImpl(gh<_i670.WeatherApiDataSource>()),
  );
  gh.lazySingleton<_i368.AuthService>(
    () => _i756.AuthServiceImpl(gh<_i32.AuthDataSource>()),
  );
  gh.factory<_i674.GetCurrentWeatherByCityUseCase>(
    () => _i674.GetCurrentWeatherByCityUseCase(gh<_i743.WeatherService>()),
  );
  gh.factory<_i464.GetCurrentWeatherUseCase>(
    () => _i464.GetCurrentWeatherUseCase(gh<_i743.WeatherService>()),
  );
  gh.factory<_i80.GetCurrentAuthUserUseCase>(
    () => _i80.GetCurrentAuthUserUseCase(gh<_i368.AuthService>()),
  );
  gh.factory<_i239.RegisterWithEmailAndPasswordUseCase>(
    () => _i239.RegisterWithEmailAndPasswordUseCase(gh<_i368.AuthService>()),
  );
  gh.factory<_i56.SignInWithEmailAndPasswordUseCase>(
    () => _i56.SignInWithEmailAndPasswordUseCase(gh<_i368.AuthService>()),
  );
  gh.factory<_i1044.SignOutUseCase>(
    () => _i1044.SignOutUseCase(gh<_i368.AuthService>()),
  );
  gh.factory<_i924.SubscribeToAuthUserChangesUseCase>(
    () => _i924.SubscribeToAuthUserChangesUseCase(gh<_i368.AuthService>()),
  );
  gh.factory<_i852.HomeCubit>(
    () => _i852.HomeCubit(
      gh<_i464.GetCurrentWeatherUseCase>(),
      gh<_i80.GetSelectedLanguageCodeUseCase>(),
      gh<_i164.CheckLocationPermissionStatusUseCase>(),
      gh<_i899.GetCurrentLocationUseCase>(),
    ),
  );
  gh.factory<_i904.RegisterCubit>(
    () => _i904.RegisterCubit(gh<_i239.RegisterWithEmailAndPasswordUseCase>()),
  );
  gh.factory<_i799.SearchCubit>(
    () => _i799.SearchCubit(
      gh<_i674.GetCurrentWeatherByCityUseCase>(),
      gh<_i80.GetSelectedLanguageCodeUseCase>(),
    ),
  );
  gh.factory<_i427.SettingsCubit>(
    () => _i427.SettingsCubit(
      gh<_i1044.SignOutUseCase>(),
      gh<_i80.GetSelectedLanguageCodeUseCase>(),
      gh<_i548.SaveLanguageCodeUseCase>(),
    ),
  );
  gh.factory<_i139.LoginCubit>(
    () => _i139.LoginCubit(gh<_i56.SignInWithEmailAndPasswordUseCase>()),
  );
  gh.factory<_i948.SessionExpirationCheckerCubit>(
    () => _i948.SessionExpirationCheckerCubit(
      gh<_i924.SubscribeToAuthUserChangesUseCase>(),
    ),
  );
  return getIt;
}

class _$SharedPreferencesModule extends _i110.SharedPreferencesModule {}

class _$InjectableFirebaseAuthModule
    extends _i284.InjectableFirebaseAuthModule {}

class _$EnvsModule extends _i253.EnvsModule {}

class _$DioModule extends _i984.DioModule {}
