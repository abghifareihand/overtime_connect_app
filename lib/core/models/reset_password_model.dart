import 'package:json_annotation/json_annotation.dart';

part 'reset_password_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ResetOtpRequest {
  ResetOtpRequest({
    required this.email,
  });

  factory ResetOtpRequest.fromJson(Map<String, dynamic> json) => _$ResetOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetOtpRequestToJson(this);

  final String email;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResetOtpResponse {
  ResetOtpResponse({
    required this.status,
    required this.message,
  });

  factory ResetOtpResponse.fromJson(Map<String, dynamic> json) => _$ResetOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetOtpResponseToJson(this);

  final String status;
  final String message;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResetPasswordRequest {
  ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
    required this.passwordConfirmation,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

  final String email;
  final String otp;
  final String password;
  final String passwordConfirmation;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResetPasswordResponse {
  ResetPasswordResponse({
    required this.status,
    required this.message,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);

  final String status;
  final String message;
}
