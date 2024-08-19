import 'package:equatable/equatable.dart';

class MakeWorkModel extends Equatable {
  final int id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final bool isActive;
  final String dateJoined;
  final String image;

  const MakeWorkModel(
    this.id,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.isActive,
    this.dateJoined,
    this.image,
  );

  @override
  List<Object?> get props =>
      [id, userName, email, firstName, lastName, dateJoined];
  
  factory MakeWorkModel.fromJson(Map<String, dynamic> json) {
    return MakeWorkModel(
      json['id'],
      json['username'],
      json['email'],
      json['first_name'],
      json['last_name'],
      json['is_active'],
      json['date_joined'],
      json['image'],
    );
  }
}
