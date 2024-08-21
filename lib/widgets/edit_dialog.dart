import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/models/makework_models.dart';

class EditDialog extends StatelessWidget {
  const EditDialog({super.key, required this.users});

  final MakeWorkModel users;

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController =
        TextEditingController(text: users.username);
    TextEditingController passwordController =
        TextEditingController(text: users.password);
    TextEditingController emailController =
        TextEditingController(text: users.email);
    TextEditingController firstNameController =
        TextEditingController(text: users.first_name);
    TextEditingController lastNameController =
        TextEditingController(text: users.last_name);

    return AlertDialog(
      title: const Text('Edit User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: userNameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Passsword'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
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
                users.is_active,
                users.date_joined,
                users.image,
                passwordController.text,
              );
              context
                  .read<MakeWorkBloc>()
                  .add(EditEvent(updatedUser: updatedUser));
              Navigator.of(context).pop();
            },
            child: const Text('Save'))
      ],
    );
  }
}
