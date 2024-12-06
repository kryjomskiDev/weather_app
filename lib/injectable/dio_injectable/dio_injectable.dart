import 'dart:io';

import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_app/data/interceptors/api_key_interceptor.dart';
import 'package:weather_app/domain/env/get_api_url_use_case.dart';
import 'package:weather_app/injectable/dio_injectable/dio_injectable.mocks.dart';
import 'package:weather_app/injectable/injectable.dart';
import 'package:weather_app/injectable/staging_environment.dart';
import 'package:system_proxy/system_proxy.dart';

const timeout = Duration(seconds: 20);

@GenerateMocks([Dio])
@module
abstract class DioModule {
  @lazySingleton
  @dev
  @prod
  @staging
  Dio dio(GetApiUrlUseCase getApiUrlUseCase) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        baseUrl: getApiUrlUseCase.getApiUrl(),
      ),
    );

    SystemProxy.getProxySettings().then((Map<String, String>? systemProxy) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        if (systemProxy != null) {
          client.findProxy = (url) => 'PROXY ${systemProxy['host']}:${systemProxy['port']}';
        }

        client.badCertificateCallback = (X509Certificate cert, String host, int port) => Platform.isAndroid;
        return client;
      };
    });

    return dio;
  }

  @singleton
  @test
  Dio testDio() => MockDio();
}

void registerInterceptors() {
  final dio = getIt<Dio>();

  dio.interceptors.addAll(
    [AuthHeaderInterceptor()],
  );
}
