import 'package:dio/dio.dart';
import 'auth_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio dio;

  ApiClient(SharedPreferences prefs)
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://cold-1-production.up.railway.app',
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(AuthInterceptor(prefs));
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
