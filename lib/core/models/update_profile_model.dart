import 'package:json_annotation/json_annotation.dart';

part 'update_profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileResponse {
  UpdateProfileResponse({
    required this.status,
    required this.message,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => _$UpdateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);

  final String status;
  final String message;
}
