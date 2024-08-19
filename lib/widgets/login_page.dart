import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:makework/widgets/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isUserLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  login(context) async {
    if (kDebugMode) {
      print("username ${usernameController.text}");
      print("password ${passwordController.text}");
    }

    Dio dio = Dio();
    final String endpoint = dotenv.env['ENDPOINT']!;
    

    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.connectTimeout = const Duration(seconds: 20);

    try {
      Response response = await dio.post('$endpoint/api/token/',
          data: FormData.fromMap({
            'username': usernameController.text,
            'password': passwordController.text,
          }));

      if (response.statusCode == 200) {
        print(response);
        isUserLogin = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['access']);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const UserPage()));
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('Incorrect username or password. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } on DioException catch (e) {
      print('Error from server : $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}