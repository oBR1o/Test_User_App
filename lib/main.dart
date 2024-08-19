import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/repositories/makework_repo_fromdb.dart';
import 'package:makework/widgets/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main()  async{
  await dotenv.load(fileName: ".env");
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
            final bloc = MakeWorkBloc(MakeWorkRepoFromDB());
            bloc.add(LoadEvent());
            return bloc;
          },
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: Center(
            child: LoginPage(),
          ),
        ),
      ),
    );
  }
}
