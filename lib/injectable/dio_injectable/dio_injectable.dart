import 'dart:io';

import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/config/envs.dart';
import 'package:weather_app/data/interceptors/api_key_interceptor.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/injectable/staging_environment.dart';
import 'package:system_proxy/system_proxy.dart';

const Duration timeout = Duration(seconds: 20);

@module
abstract class DioModule {
  @lazySingleton
  @dev
  @prod
  @staging
  Dio dio(Envs envs) {
    final Dio dio = Dio(
      BaseOptions(connectTimeout: timeout, receiveTimeout: timeout, sendTimeout: timeout, baseUrl: envs.apiUrl),
    );

    SystemProxy.getProxySettings().then((Map<String, String>? systemProxy) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final HttpClient client = HttpClient();
        if (systemProxy != null) {
          client.findProxy = (Uri url) => 'PROXY ${systemProxy['host']}:${systemProxy['port']}';
        }

        client.badCertificateCallback = (X509Certificate cert, String host, int port) => Platform.isAndroid;
        return client;
      };
    });

    return dio;
  }

  @singleton
  @test
  Dio testDio() => Dio(BaseOptions());
}

void registerInterceptors() {
  final Dio dio = getIt<Dio>();

  dio.interceptors.addAll(<Interceptor>[AuthHeaderInterceptor(getIt<Envs>())]);
}
