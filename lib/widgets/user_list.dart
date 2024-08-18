import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:intl/intl.dart';
class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = context.select((MakeWorkBloc bloc) => bloc.state.users);

    if (users.isEmpty) {
      return const SizedBox(
        height: 200,
        width: double.infinity,
        child: Center(
          child: Text(
            "Nothing to show",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Card(
          shadowColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 5,
            bottom: 5,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text('${users[index].firstName} ${users[index].lastName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('email: ${users[index].email}'),
                  Text('username: ${users[index].userName}'),
                  Text('joined: ${DateFormat('dd/MM/yyyy').format(users[index].dateJoined!)}'),
                ],
              )
            ),
          ),
        );
      },
    );
  }
}
