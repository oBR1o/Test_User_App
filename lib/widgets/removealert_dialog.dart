
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/models/makework_models.dart';


class RemoveAlertDialog extends StatelessWidget {
  const RemoveAlertDialog({super.key, required this.users});

  final MakeWorkModel users;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: Text(
          'Do you want to delete "${users.userName}" ?'),
      actions:[
        TextButton(
          child: const Text('Cancle'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            context.read<MakeWorkBloc>().add(
                RemoveEvent(
                    id: users.id));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
