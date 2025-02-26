import 'package:json_annotation/json_annotation.dart';

part 'update_password_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePasswordRequest {
  UpdatePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) => _$UpdatePasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);

  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePasswordResponse {
  UpdatePasswordResponse({
    required this.status,
    required this.message,
  });

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) => _$UpdatePasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePasswordResponseToJson(this);

  final String status;
  final String message;
}
