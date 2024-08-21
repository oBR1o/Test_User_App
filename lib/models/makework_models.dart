import 'package:equatable/equatable.dart';

class MakeWorkModel extends Equatable {
  final int id;
  final String username;
  final String email;
  final String? first_name;
  final String? last_name;
  final bool is_active;
  final DateTime? date_joined;
  final String image;
  final String password;

  const MakeWorkModel(
    this.id,
    this.username,
    this.email,
    this.first_name,
    this.last_name,
    this.is_active,
    this.date_joined,
    this.image,
    this.password
  );

  @override
  List<Object?> get props =>
      [id, username, email, first_name, last_name, date_joined];
  
  factory MakeWorkModel.fromJson(Map<String, dynamic> json) {
    return MakeWorkModel(
      json['id'],
      json['username'],
      json['email'],
      json['first_name'] != null ? (json['first_name']) : null,
      json['last_name'] != null ? (json['last_name']) : null,
      json['is_active'],
      json['date_joined'] != null ? DateTime.parse(json['date_joined']) : null,
      json['image'],
      '',
    );
  } 
}

