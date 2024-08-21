import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/network/api_server.dart';
import 'package:makework/widgets/login_page.dart';
import 'package:makework/widgets/user_list.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final ApiServer apiServer = ApiServer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'), 
        actions: [
          IconButton(
            onPressed: () {
              apiServer.logout().then((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<MakeWorkBloc, MakeWorkState>(
        builder: (context, state) {
          return state is LoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const UserList();
        },
      ),
    );
  }
}
