// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_by_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportByIdResponse _$ReportByIdResponseFromJson(Map<String, dynamic> json) =>
    ReportByIdResponse(
      success: json['success'] as bool,
      data: ReportByIdData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportByIdResponseToJson(ReportByIdResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

ReportByIdData _$ReportByIdDataFromJson(Map<String, dynamic> json) =>
    ReportByIdData(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      date: json['date'] as String,
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      dayType: json['day_type'] as String,
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$ReportByIdDataToJson(ReportByIdData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'overtime_hours': instance.overtimeHours,
      'status': instance.status,
      'day_type': instance.dayType,
      'total_overtime': instance.totalOvertime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
