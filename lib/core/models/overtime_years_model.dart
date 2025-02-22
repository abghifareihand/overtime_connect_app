import 'package:json_annotation/json_annotation.dart';

part 'overtime_years_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OvertimeYearsResponse {
  OvertimeYearsResponse({
    required this.status,
    required this.message,
    required this.years,
  });

  factory OvertimeYearsResponse.fromJson(Map<String, dynamic> json) => _$OvertimeYearsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeYearsResponseToJson(this);

  final String status;
  final String message;
  final List<String> years;
}
