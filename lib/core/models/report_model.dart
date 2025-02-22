import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportResponse {
  ReportResponse({
    required this.status,
    required this.message,
    required this.month,
    required this.year,
    required this.totalHours,
    required this.totalAmount,
    required this.data,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);

  final String status;
  final String message;
  final String month;
  final String year;
  final double totalHours;
  final double totalAmount;
  final List<ReportData> data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportData {
  ReportData({
    required this.id,
    required this.userId,
    required this.date,
    required this.overtimeHours,
    required this.totalOvertime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.dayType,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) => _$ReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDataToJson(this);

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
