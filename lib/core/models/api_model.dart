import 'package:json_annotation/json_annotation.dart';

part 'api_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiResponse {
  ApiResponse({
    required this.status,
    required this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  final String status;
  final String message;
}
