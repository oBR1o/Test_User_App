import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({
    super.key,
  });

  @override
  AddDialogState createState() => AddDialogState();
}

class AddDialogState extends State<AddDialog> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool isSaveEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Add User'),
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  setState(() {
                    isSaveEnabled = value.isNotEmpty;
                  });
                },
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    isSaveEnabled = value.isNotEmpty;
                  });
                },
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    isSaveEnabled = value.isNotEmpty;
                  });
                },
              ),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                onChanged: (value) {
                  setState(() {
                    isSaveEnabled = value.isNotEmpty;
                  });
                },
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                onChanged: (value) {
                  setState(() {
                    isSaveEnabled = value.isNotEmpty;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: isSaveEnabled
                        ? () {
                            String? userName = userNameController.text;
                            String? password = userNameController.text;
                            String? email = emailController.text;
                            String? firstName = firstNameController.text;
                            String? lastName = lastNameController.text;
                            context.read<MakeWorkBloc>().add(AddEvent(userName,
                                email, firstName, lastName, password));
                            context.read<MakeWorkBloc>().add(LoadEvent());
                            Navigator.pop(context, 'save');
                          }
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('Please fill in all fields.'),
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
                          },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
