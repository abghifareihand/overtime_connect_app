import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterRequest {
  RegisterRequest({
    required this.fullname,
    required this.email,
    required this.username,
    required this.phone,
    required this.salary,
    required this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  final String fullname;
  final String email;
  final String username;
  final String phone;
  final double salary;
  final String password;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterResponse {
  RegisterResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  final String status;
  final String message;
  final String token;
  final User user;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  User({
    required this.fullname,
    required this.email,
    required this.username,
    required this.phone,
    required this.salary,
    this.photo,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String fullname;
  final String email;
  final String username;
  final String phone;
  final int salary;
  final String? photo;
  final String updatedAt;
  final String createdAt;
  final int id;
}
