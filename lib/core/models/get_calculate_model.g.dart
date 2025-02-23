// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_calculate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCalculateResponse _$GetCalculateResponseFromJson(
        Map<String, dynamic> json) =>
    GetCalculateResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CalculateData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCalculateResponseToJson(
        GetCalculateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CalculateData _$CalculateDataFromJson(Map<String, dynamic> json) =>
    CalculateData(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      totalOvertime: (json['total_overtime'] as num).toDouble(),
    );

Map<String, dynamic> _$CalculateDataToJson(CalculateData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'total_overtime': instance.totalOvertime,
    };

GetCalculateDetailResponse _$GetCalculateDetailResponseFromJson(
        Map<String, dynamic> json) =>
    GetCalculateDetailResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: CalculateDetail.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCalculateDetailResponseToJson(
        GetCalculateDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CalculateDetail _$CalculateDetailFromJson(Map<String, dynamic> json) =>
    CalculateDetail(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      overtimeDetails: (json['overtime_details'] as List<dynamic>)
          .map((e) => OvertimeDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalculateDetailToJson(CalculateDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'total_overtime': instance.totalOvertime,
      'overtime_details': instance.overtimeDetails,
    };

OvertimeDetail _$OvertimeDetailFromJson(Map<String, dynamic> json) =>
    OvertimeDetail(
      formula: json['formula'] as String,
      result: (json['result'] as num).toDouble(),
    );

Map<String, dynamic> _$OvertimeDetailToJson(OvertimeDetail instance) =>
    <String, dynamic>{
      'formula': instance.formula,
      'result': instance.result,
    };
