import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';


class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  
Widget build(BuildContext context) {
    final users = context.select((MakeWorkBloc bloc) => bloc.state.users);
    return Expanded(
      child: users.isEmpty
            ? const SizedBox(
                height: 200,
                width: double.infinity,
                child: Text(
                  "Nothing to show",
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index].userName),
                  );
                }));
  }
}