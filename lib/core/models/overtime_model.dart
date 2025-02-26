import 'package:json_annotation/json_annotation.dart';
import 'package:overtime_connect_app/core/models/calculate_overtime_model.dart';

part 'overtime_model.g.dart';

// Ensure OvertimeDetail is the same across models
@JsonSerializable(fieldRename: FieldRename.snake)
class AddOvertimeRequest {
  AddOvertimeRequest({
    required this.date,
    required this.overtimeHours,
    required this.totalOvertime,
    required this.status,
    required this.dayType,
    required this.overtimeDetails, // New field for overtime details
  });

  factory AddOvertimeRequest.fromJson(Map<String, dynamic> json) => _$AddOvertimeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddOvertimeRequestToJson(this);

  final String date;
  final double overtimeHours;
  final double totalOvertime;
  final int status;
  final String dayType;
  final List<OvertimeDetail> overtimeDetails; // Use consistent OvertimeDetail
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AddOvertimeResponse {
  AddOvertimeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddOvertimeResponse.fromJson(Map<String, dynamic> json) => _$AddOvertimeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddOvertimeResponseToJson(this);

  final String status;
  final String message;
  final OvertimeData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OvertimeData {
  OvertimeData({
    required this.userId,
    required this.date,
    required this.overtimeHours,
    required this.totalOvertime,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.dayType,
  });

  factory OvertimeData.fromJson(Map<String, dynamic> json) => _$OvertimeDataFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeDataToJson(this);

  final int userId;
  final String date;
  final double overtimeHours;
  final double totalOvertime;
  final int status;
  final String updatedAt;
  final String createdAt;
  final int id;
  final String dayType;
}
