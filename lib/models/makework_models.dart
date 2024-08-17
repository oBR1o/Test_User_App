import 'package:equatable/equatable.dart';

class MakeWorkModel extends Equatable {
  final int id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final bool isActive;
  final DateTime? dateJoined;

  const MakeWorkModel(
    this.id,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.isActive,
    this.dateJoined,
  );

  @override
  List<Object?> get props =>
      [id, userName, email, firstName, lastName, dateJoined];
}
