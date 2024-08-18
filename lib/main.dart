import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/repositories/makework_mock_repository.dart';
import 'package:makework/widgets/user_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MakeWorkBloc>(
          create: (context) {
            final bloc = MakeWorkBloc(MakeWorkMockRepository());
            bloc.add(LoadEvent());
            return bloc;
          },
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: Center(
            child: UserPage(),
          ),
        ),
      ),
    );
  }
}
