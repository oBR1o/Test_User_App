import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/widgets/user_list.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MakeWorkBloc, MakeWorkState>(
      builder: (context, state) {
        return state is LoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const UserList();
      },
    );
  }
}
