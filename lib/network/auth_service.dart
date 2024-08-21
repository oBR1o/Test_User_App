import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String? accessToken;

  Future<void> useAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access');

    if (accessToken != null) {
      print('Access Token: $accessToken');
    } else {
      print('No Access Token found!');
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access');
  }
}
