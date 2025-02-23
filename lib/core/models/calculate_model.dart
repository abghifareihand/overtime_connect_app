import 'package:json_annotation/json_annotation.dart';

part 'calculate_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddCalculateRequest {
  AddCalculateRequest({
    required this.date,
    required this.monthlySalary,
    required this.dayType,
    required this.workingDays,
    required this.overtimeHours,
  });

  factory AddCalculateRequest.fromJson(Map<String, dynamic> json) => _$AddCalculateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddCalculateRequestToJson(this);

  final String date;
  final double monthlySalary;
  final String dayType;
  final int workingDays;
  final double overtimeHours;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AddCalculateResponse {
  AddCalculateResponse({
    required this.status,
    required this.message,
  });

  factory AddCalculateResponse.fromJson(Map<String, dynamic> json) => _$AddCalculateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddCalculateResponseToJson(this);

  final String status;
  final String message;
}
