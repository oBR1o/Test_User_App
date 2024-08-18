import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:intl/intl.dart';
import 'package:makework/widgets/removealert_dialog.dart';

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

    return Stack(
      children: [
        ListView.builder(
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                          '${users[index].firstName} ${users[index].lastName}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('email: ${users[index].email}'),
                          Text('username: ${users[index].userName}'),
                          Text(
                              'joined: ${DateFormat('dd/MM/yyyy').format(users[index].dateJoined!)}'),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RemoveAlertDialog(
                                    users: users[index],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: () {},
                shape: const CircleBorder(),
                child: const Icon(Icons.person_add, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
