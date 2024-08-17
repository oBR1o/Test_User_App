import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';

class MakeWorkBloc extends Bloc<MakeWorkEvent, MakeWorkState>{
  MakeWorkBloc(): super(LoadState());
}