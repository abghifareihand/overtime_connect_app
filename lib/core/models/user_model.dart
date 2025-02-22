import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse {
  UserResponse({
    required this.status,
    required this.message,
    required this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  final String status;
  final String message;
  final User user;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.username,
    required this.phone,
    required this.salary,
    required this.workingDays,
    this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  final int id;
  final String fullname;
  final String email;
  final String username;
  final String phone;
  final double salary;
  final int workingDays;
  final String? photo;
  final String createdAt;
  final String updatedAt;
}
