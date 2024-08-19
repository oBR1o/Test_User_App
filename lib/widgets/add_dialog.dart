import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var emailController = TextEditingController();
    var userNameController = TextEditingController();
    return SimpleDialog(
      title: const Text('Add User'),
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    String? firstName = firstNameController.text;
                    String? lastName = lastNameController.text;
                    String? email = emailController.text;
                    String? userName = userNameController.text;
                    context.read<MakeWorkBloc>().add(AddEvent(userName,  email, firstName, lastName));
                    context.read<MakeWorkBloc>().add(LoadEvent());
                    Navigator.pop(context,'save');
                  },
                  child: const Text('Add'),
                ),
              ])
            ],
          ),
        ),
      ],
    );
  }
}
