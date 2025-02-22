import 'package:json_annotation/json_annotation.dart';

part 'report_monthly_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportMonthlyResponse {
  ReportMonthlyResponse({
    required this.status,
    required this.monthStart,
    required this.monthEnd,
    required this.totalHours,
    required this.totalAmount,
    required this.data,
  });

  factory ReportMonthlyResponse.fromJson(Map<String, dynamic> json) => _$ReportMonthlyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportMonthlyResponseToJson(this);

  final String status;
  final String monthStart;
  final String monthEnd;
  final double totalHours;
  final double totalAmount;
  final List<ReportMonthlyData> data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportMonthlyData {
  ReportMonthlyData({
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

  factory ReportMonthlyData.fromJson(Map<String, dynamic> json) => _$ReportMonthlyDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportMonthlyDataToJson(this);

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
