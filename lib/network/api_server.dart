import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:makework/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String endpoint = dotenv.env['ENDPOINT']!;

class ApiServer {
  final DioClient _dioClient = DioClient();

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dioClient.dio.post(
        'token/',
        data: {
          'username': username,
          'password': password,
        },
      );

      // ตรวจสอบว่าการ login สำเร็จหรือไม่
      if (response.statusCode == 200) {
        // รับ accessToken จาก response
        String accessToken = response.data['access'];

        // เก็บ accessToken ใน SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access', accessToken);

        print('Login successful: $accessToken');
        return true;
      } else {
        print('Login failed: Invalid status code ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }
}
