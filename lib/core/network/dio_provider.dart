import 'package:dio/dio.dart';
import 'package:find_me_words/core/network/api_endpoints.dart';

class DioProvider {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),

        headers: {
          'Content-Type': 'application/json'
        }
      )
    );

    return dio;
  }
}