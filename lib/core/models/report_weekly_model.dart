import 'package:json_annotation/json_annotation.dart';

part 'report_weekly_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportWeeklyResponse {
  ReportWeeklyResponse({
    required this.status,
    required this.weekStart,
    required this.weekEnd,
    required this.totalHours,
    required this.totalAmount,
    required this.data,
  });

  factory ReportWeeklyResponse.fromJson(Map<String, dynamic> json) => _$ReportWeeklyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportWeeklyResponseToJson(this);

  final String status;
  final String weekStart;
  final String weekEnd;
  final double totalHours;
  final double totalAmount;
  final List<ReportWeeklyData> data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportWeeklyData {
  ReportWeeklyData({
    required this.id,
    required this.userId,
    required this.date,
    required this.overtimeHours,
    required this.totalOvertime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.dayType, // Tambahkan dayType yang nullable
  });

  factory ReportWeeklyData.fromJson(Map<String, dynamic> json) => _$ReportWeeklyDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportWeeklyDataToJson(this);

  final int id;
  final int userId;
  final String date;
  final double overtimeHours;
  final double totalOvertime;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String dayType; // Nullable dayType
}
