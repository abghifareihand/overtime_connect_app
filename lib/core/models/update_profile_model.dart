import 'package:json_annotation/json_annotation.dart';

part 'update_profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileResponse {
  UpdateProfileResponse({
    required this.status,
    required this.message,
    required this.user,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => _$UpdateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);

  final String status;
  final String message;
  final UserProfile user;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserProfile {
  UserProfile({
    required this.fullname,
    required this.phone,
    required this.salary,
    required this.workingDays,
    required this.photo,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  final String fullname;
  final String phone;
  final double salary;
  final int workingDays;
  final String photo;
}
