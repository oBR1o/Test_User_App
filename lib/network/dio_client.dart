import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late Dio _dio;
  bool isRefreshing = false; // Flag to prevent multiple refreshes
  List<Function> pendingRequests = []; // Queue for pending requests

  DioClient() {
    _dio = Dio();

    _dio.options.baseUrl = '${dotenv.env['ENDPOINT']}/api/';
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    _dio.options.connectTimeout = const Duration(seconds: 20);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('access');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401 && !isRefreshing) {
            isRefreshing = true;

            try {
              final newTokens = await refreshToken();
              if (newTokens != null) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('access', newTokens['access']?? '');
                await prefs.setString('REFRESH_TOKEN', newTokens['refresh']?? '');

                // Update the failed request with the new token and retry
                error.requestOptions.headers['Authorization'] =
                    'Bearer ${newTokens['access']}';
                final response = await _dio.fetch(error.requestOptions);

                // Resolve all pending requests
                pendingRequests.forEach((callback) => callback());
                pendingRequests.clear();

                isRefreshing = false;
                return handler.resolve(response);
              } else {
                handleTokenRefreshFailure();
                isRefreshing = false;
              }
            } catch (e) {
              isRefreshing = false;
              return handler.reject(error);
            }
          } else if (isRefreshing) {
            // Queue requests while refreshing
            pendingRequests.add(() async {
              final token = await getAccessToken();
              if (token != null) {
                error.requestOptions.headers['Authorization'] = 'Bearer $token';
                final response = await _dio.fetch(error.requestOptions);
                handler.resolve(response);
              }
            });
          } else {
            return handler.next(error);
          }
        },
      ),
    );
  }

  Future<Map<String, String>?> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('REFRESH_TOKEN');
      if (refreshToken == null) throw Exception('No refresh token found');

      final response = await _dio.post(
        '${dotenv.env['ENDPOINT']}/api/token/refresh/',
        data: {'refresh': refreshToken},
      );

      final data = response.data;
      return {
        'access': data['access'],
        'refresh': data['refresh'],
      };
    } catch (e) {
      print('Failed to refresh token: $e');
      return null;
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access');
  }

  void handleTokenRefreshFailure() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access');
    await prefs.remove('REFRESH_TOKEN');
  }

  Dio get dio => _dio; 
}