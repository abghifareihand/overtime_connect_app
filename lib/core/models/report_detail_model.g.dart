// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDetailResponse _$ReportDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ReportDetailResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      date: json['date'] as String,
      dayType: json['day_type'] as String,
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      data: (json['data'] as List<dynamic>)
          .map((e) => OvertimeDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportDetailResponseToJson(
        ReportDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'date': instance.date,
      'day_type': instance.dayType,
      'overtime_hours': instance.overtimeHours,
      'total_overtime': instance.totalOvertime,
      'data': instance.data,
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
