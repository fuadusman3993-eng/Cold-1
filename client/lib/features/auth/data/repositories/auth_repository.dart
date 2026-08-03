import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SharedPreferences prefs;

  AuthRepository(this.apiClient, this.prefs);

  Future<bool> sendOtp(String phone) async {
    try {
      final response = await apiClient.dio.post('/auth/send-otp', data: {'phone': phone});
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to send OTP');
    }
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    try {
      final response = await apiClient.dio.post('/auth/verify-otp', data: {'phone': phone, 'otp': otp});
      if (response.statusCode == 201 || response.statusCode == 200) {
        final accessToken = response.data['data']['accessToken'];
        final refreshToken = response.data['data']['refreshToken'];
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Invalid OTP');
    }
  }

  Future<void> logout() async {
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  bool isAuthenticated() {
    return prefs.getString('access_token') != null;
  }
}
