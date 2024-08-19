import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makework/bloc/app_bloc.dart';
import 'package:makework/repositories/makework_repository.dart';

class MakeWorkBloc extends Bloc<MakeWorkEvent, MakeWorkState>{
  final MakeWorkRepository repository;
  MakeWorkBloc(this.repository): super(LoadingState()){
    on<LoadEvent>(_onLoaded);
    on<RemoveEvent>(_onRemoved);
    on<EditEvent>(_onEdited);
    on<AddEvent>(_onAdded);
  }

  _onLoaded(LoadEvent event, Emitter<MakeWorkState> emit) async {
    if(state is LoadingState){
      final users = await repository.load();
      emit(ReadyState(users: users));
    }
  }

  _onRemoved(RemoveEvent event, Emitter<MakeWorkState> emit) async { 
      await repository.remove(id: event.id);
      emit(LoadingState());
      add(LoadEvent());   
  }

  _onEdited(EditEvent event, Emitter<MakeWorkState> emit) async {
    await repository.update(event.updatedUser);
    emit(LoadingState());
    add(LoadEvent());
  }

  _onAdded(AddEvent event, Emitter<MakeWorkState> emit) async {
    await repository.add(userName: event.userName, email: event.email, firstName: event.firstName, lastName: event.lastName);
    emit(LoadingState());
    add(LoadEvent());
  }
}
  
