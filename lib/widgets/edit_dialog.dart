import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/models/makework_models.dart';

class EditDialog extends StatelessWidget {
  const EditDialog({super.key, required this.users});

  final MakeWorkModel users;

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController =
        TextEditingController(text: users.firstName);
    TextEditingController lastNameController =
        TextEditingController(text: users.lastName);
    TextEditingController emailController =
        TextEditingController(text: users.email);
    TextEditingController userNameController =
        TextEditingController(text: users.userName);

    return AlertDialog(
      title: const Text('Edit User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
            onPressed: () {
              MakeWorkModel updatedUser = MakeWorkModel(
                users.id,
                userNameController.text,
                emailController.text,
                firstNameController.text,
                lastNameController.text,
                users.isActive,
                users.dateJoined,
                users.image
              );
              context.read<MakeWorkBloc>().add(EditEvent(updatedUser : updatedUser));
              Navigator.of(context).pop();
            },
            child: const Text('Save'))
      ],
    );
  }
}
