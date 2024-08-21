import 'package:flutter/material.dart';
import 'package:makework/network/api_server.dart';
import 'package:makework/widgets/user_page.dart';

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
  final ApiServer _apiServer = ApiServer();

  Future<void> login() async {
  bool success = await _apiServer.login(
    usernameController.text,
    passwordController.text,
  );
  if (success) {
    changePage();
    print('Login successful');
  } else {
    showErrorDialog('Login failed. Please try again.');
  }
}

  void changePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserPage()));
  }


  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
              onPressed: () => login(),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
