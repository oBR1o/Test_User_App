import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/repositories/makework_repository.dart';

class MakeWorkBloc extends Bloc<MakeWorkEvent, MakeWorkState>{
  final MakeWorkRepository repository;
  MakeWorkBloc(this.repository): super(LoadingState()){
    on<LoadEvent>(_onLoaded);
  }

  _onLoaded(LoadEvent event, Emitter<MakeWorkState> emit) async {
    final users = await repository.load();
    emit(ReadyState(users: users));
  }
}
  
