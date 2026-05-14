import 'package:dio/dio.dart';
import 'package:weather_app/config/envs.dart';
import 'package:weather_app/networking_config/query.dart';

class AuthHeaderInterceptor extends Interceptor {
  final Envs envs;

  AuthHeaderInterceptor(this.envs);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters[appId] = envs.apiKey;

    handler.next(options);
  }
}
