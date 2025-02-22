import 'package:json_annotation/json_annotation.dart';

part 'overtime_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddOvertimeRequest {
  AddOvertimeRequest({
    required this.date,
    required this.overtimeHours,
    required this.totalOvertime,
    required this.status,
    required this.dayType, // Tambahkan dayType yang nullable
  });

  factory AddOvertimeRequest.fromJson(Map<String, dynamic> json) => _$AddOvertimeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddOvertimeRequestToJson(this);

  final String date;
  final double overtimeHours;
  final double totalOvertime;
  final int status;
  final String dayType; // Nullable dayType
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
    required this.dayType, // Tambahkan dayType yang nullable
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
  final String dayType; // Nullable dayType
}
