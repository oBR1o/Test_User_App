import 'package:makework/models/makework_models.dart';

sealed class MakeWorkState{
  final List<MakeWorkModel> users;
  MakeWorkState({required this.users});
}

const List<MakeWorkModel> empty = [];
class LoadingState extends MakeWorkState{
  LoadingState(): super(users: empty);
}

class ReadyState extends MakeWorkState{
  ReadyState({required super.users});
  
}