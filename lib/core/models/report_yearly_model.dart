import 'package:json_annotation/json_annotation.dart';

part 'report_yearly_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportYearlyResponse {
  ReportYearlyResponse({
    required this.status,
    required this.year,
    required this.totalHours,
    required this.totalAmount,
    required this.data,
  });

  factory ReportYearlyResponse.fromJson(Map<String, dynamic> json) => _$ReportYearlyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportYearlyResponseToJson(this);

  final String status;
  final String year;
  final double totalHours;
  final double totalAmount;
  final Map<String, ReportYearlyMonthData> data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportYearlyMonthData {
  ReportYearlyMonthData({
    required this.month,
    required this.totalHours,
    required this.totalAmount,
    required this.overtimes,
  });

  factory ReportYearlyMonthData.fromJson(Map<String, dynamic> json) => _$ReportYearlyMonthDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportYearlyMonthDataToJson(this);

  final String month;
  final double totalHours;
  final double totalAmount;
  final List<ReportOvertimeData> overtimes;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportOvertimeData {
  ReportOvertimeData({
    required this.id,
    required this.userId,
    required this.date,
    required this.overtimeHours,
    required this.totalOvertime,
    required this.status,
    required this.dayType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportOvertimeData.fromJson(Map<String, dynamic> json) => _$ReportOvertimeDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportOvertimeDataToJson(this);

  final int id;
  final int userId;
  final String date;
  final double overtimeHours;
  final double totalOvertime;
  final int status;
  final String dayType;
  final String createdAt;
  final String updatedAt;
}
