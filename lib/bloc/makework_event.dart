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