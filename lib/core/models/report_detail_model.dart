import 'package:json_annotation/json_annotation.dart';

part 'report_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportDetailResponse {
  ReportDetailResponse({
    required this.status,
    required this.message,
    required this.date,
    required this.dayType,
    required this.overtimeHours,
    required this.totalOvertime,
    required this.data,
  });

  factory ReportDetailResponse.fromJson(Map<String, dynamic> json) => _$ReportDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDetailResponseToJson(this);

  final String status;
  final String message;
  final String date;
  final String dayType;
  final double overtimeHours;
  final double totalOvertime;
  final List<OvertimeDetail> data;
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
