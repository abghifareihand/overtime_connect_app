import 'package:json_annotation/json_annotation.dart';

part 'get_calculate_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetCalculateResponse {
  GetCalculateResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCalculateResponse.fromJson(Map<String, dynamic> json) => _$GetCalculateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetCalculateResponseToJson(this);

  final String status;
  final String message;
  final List<CalculateData> data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CalculateData {
  CalculateData({
    required this.id,
    required this.date,
    required this.totalOvertime,
  });

  factory CalculateData.fromJson(Map<String, dynamic> json) => _$CalculateDataFromJson(json);
  Map<String, dynamic> toJson() => _$CalculateDataToJson(this);

  final int id;
  final String date;
  final double totalOvertime;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetCalculateDetailResponse {
  GetCalculateDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCalculateDetailResponse.fromJson(Map<String, dynamic> json) => _$GetCalculateDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetCalculateDetailResponseToJson(this);

  final String status;
  final String message;
  final CalculateDetail data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CalculateDetail {
  CalculateDetail({
    required this.id,
    required this.date,
    required this.totalOvertime,
    required this.overtimeDetails,
  });

  factory CalculateDetail.fromJson(Map<String, dynamic> json) => _$CalculateDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CalculateDetailToJson(this);

  final int id;
  final String date;
  final double totalOvertime;
  final List<OvertimeDetail> overtimeDetails;
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
