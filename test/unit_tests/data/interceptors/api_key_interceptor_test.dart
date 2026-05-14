import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/config/envs.dart';
import 'package:weather_app/data/interceptors/api_key_interceptor.dart';
import 'package:weather_app/networking_config/query.dart';

import 'api_key_interceptor_test.mocks.dart';

@GenerateMocks([RequestInterceptorHandler, Envs])
void main() {
  late AuthHeaderInterceptor interceptor;
  late RequestInterceptorHandler handler;
  late Envs envs;

  setUp(() {
    handler = MockRequestInterceptorHandler();
    envs = MockEnvs();
    interceptor = AuthHeaderInterceptor(envs);
  });

  group('AuthHeaderInterceptor onRequest method', () {
    final options = RequestOptions(path: 'https://sampleurl.com');

    test('should add api key to the request', () async {
      when(envs.apiKey).thenReturn('1234567890');

      await interceptor.onRequest(options, handler);
      verify(handler.next(options));
      expect(options.queryParameters[appId], equals('1234567890'));
    });
  });
}
