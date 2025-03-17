import 'package:dio/dio.dart';

class DioClient {
  static const String _baseUrl = 'http://185.222.241.94:8088/';
  static const String _authToken = 'SmartGarden2549762015';

  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'X-AUTH-TOKEN': _authToken,
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}
