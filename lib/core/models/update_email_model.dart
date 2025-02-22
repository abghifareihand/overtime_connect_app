import 'package:json_annotation/json_annotation.dart';

part 'update_email_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateEmailRequest {
  UpdateEmailRequest({
    required this.email,
    required this.password,
  });

  factory UpdateEmailRequest.fromJson(Map<String, dynamic> json) => _$UpdateEmailRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateEmailRequestToJson(this);

  final String email;
  final String password;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateEmailResponse {
  UpdateEmailResponse({
    required this.status,
    required this.message,
    required this.email,
  });

  factory UpdateEmailResponse.fromJson(Map<String, dynamic> json) => _$UpdateEmailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateEmailResponseToJson(this);

  final String status;
  final String message;
  final String email;
}
