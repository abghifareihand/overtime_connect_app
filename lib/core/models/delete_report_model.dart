import 'package:json_annotation/json_annotation.dart';

part 'delete_report_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeleteReportResponse {
  DeleteReportResponse({
    required this.status,
    required this.message,
  });

  factory DeleteReportResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteReportResponseToJson(this);

  final String status;
  final String message;
}
