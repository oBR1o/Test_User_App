import 'package:makework/models/makework_models.dart';

sealed class MakeWorkEvent{}

class LoadEvent extends MakeWorkEvent{}

class AddEvent extends MakeWorkEvent{
    final String userName;
    final String email;
    final String firstName;
    final String lastName;
    AddEvent(this.userName, this.email, this.firstName, this.lastName);
}

class RemoveEvent extends MakeWorkEvent{
    final int id;
    RemoveEvent({required this.id});
}

class EditEvent extends MakeWorkEvent{
  final MakeWorkModel updatedUser;

  EditEvent({required this.updatedUser});
}
