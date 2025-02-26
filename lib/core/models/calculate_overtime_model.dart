import 'package:json_annotation/json_annotation.dart';

part 'calculate_overtime_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CalculateOvertimeRequest {
  CalculateOvertimeRequest({
    required this.monthlySalary,
    required this.dayType,
    required this.workingDays,
    required this.overtimeHours,
  });

  factory CalculateOvertimeRequest.fromJson(Map<String, dynamic> json) => _$CalculateOvertimeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CalculateOvertimeRequestToJson(this);

  final double monthlySalary;
  final String dayType;
  final int workingDays;
  final double overtimeHours;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CalculateOvertimeResponse {
  CalculateOvertimeResponse({
    required this.status,
    required this.message,
    required this.totalOvertime,
    required this.overtimeDetails,
  });

  factory CalculateOvertimeResponse.fromJson(Map<String, dynamic> json) => _$CalculateOvertimeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CalculateOvertimeResponseToJson(this);

  final String status;
  final String message;
  final double totalOvertime;
  final List<OvertimeDetail> overtimeDetails;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OvertimeDetail {
  OvertimeDetail({
    required this.formula,
    required this.result,
  });

  factory OvertimeDetail.fromJson(Map<String, dynamic> json) => _$OvertimeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeDetailToJson(this);

  final String formula;
  final double result;
}
