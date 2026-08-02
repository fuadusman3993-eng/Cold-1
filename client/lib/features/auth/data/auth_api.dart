import 'package:dio/dio.dart';

class AuthApi {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/api/v1'));

  Future<bool> login(String phone, String otp) async {
    try {
      final response = await dio.post('/auth/login/phone', data: {
        'phone': phone,
        'otp': otp,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Token received successfully
        return true;
      }
      return false;
    } catch (e) {
      // In a real app, handle DioError properly
      return false;
    }
  }
}
