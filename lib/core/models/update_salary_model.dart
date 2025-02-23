import 'package:json_annotation/json_annotation.dart';

part 'update_salary_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateSalaryRequest {
  UpdateSalaryRequest({
    required this.salary,
    required this.password,
  });

  factory UpdateSalaryRequest.fromJson(Map<String, dynamic> json) => _$UpdateSalaryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSalaryRequestToJson(this);

  final double salary;
  final String password;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateSalaryResponse {
  UpdateSalaryResponse({
    required this.status,
    required this.message,
    required this.salary,
  });

  factory UpdateSalaryResponse.fromJson(Map<String, dynamic> json) => _$UpdateSalaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSalaryResponseToJson(this);

  final String status;
  final String message;
  final double salary;
}
