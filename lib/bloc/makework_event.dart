import 'package:makework/models/makework_models.dart';

sealed class MakeWorkEvent{}

class LoadEvent extends MakeWorkEvent{}

class AddEvent extends MakeWorkEvent{
    final int id;
    final String userName;
    final String email;
    final String firstName;
    final String lastName;
    final bool isActive;
    final DateTime? dateJoined;
    AddEvent(this.id, this.userName, this.email, this.firstName, this.lastName, this.isActive, this.dateJoined);
}

class RemoveEvent extends MakeWorkEvent{
    final int id;
    RemoveEvent({required this.id});
}

class EditEvent extends MakeWorkEvent{
  final MakeWorkModel updatedUser;

  EditEvent({required this.updatedUser});
}
