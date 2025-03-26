import 'package:json_annotation/json_annotation.dart';

part 'report_by_id_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportByIdResponse {
  ReportByIdResponse({
    required this.success,
    required this.data,
  });

  factory ReportByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportByIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportByIdResponseToJson(this);

  final bool success;
  final ReportByIdData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportByIdData {
  ReportByIdData({
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

  factory ReportByIdData.fromJson(Map<String, dynamic> json) => _$ReportByIdDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportByIdDataToJson(this);

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
