import 'package:dio/dio.dart';
import 'package:weather_app/networking_config/query.dart';

class AuthHeaderInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.queryParameters[appId] = const String.fromEnvironment('API_KEY');

    handler.next(options);
  }
}
