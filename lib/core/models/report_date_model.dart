import 'package:json_annotation/json_annotation.dart';

part 'report_date_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportDateResponse {
  ReportDateResponse({
    required this.success,
    required this.dateRange,
    required this.totalHours,
    required this.totalAmount,
    required this.data,
  });

  factory ReportDateResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportDateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDateResponseToJson(this);

  final bool success;
  final String dateRange;
  final double totalHours;
  final double totalAmount;
  final List<ReportDateData> data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportDateData {
  ReportDateData({
    required this.id,
    required this.userId,
    required this.date,
    required this.overtimeHours,
    required this.status,
    required this.dayType,
    required this.totalOvertime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportDateData.fromJson(Map<String, dynamic> json) => _$ReportDateDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDateDataToJson(this);

  final int id;
  final int userId;
  final String date;
  final double overtimeHours;
  final int status;
  final String dayType;
  final double totalOvertime;
  final String createdAt;
  final String updatedAt;
}
