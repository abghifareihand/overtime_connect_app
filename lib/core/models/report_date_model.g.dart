// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDateResponse _$ReportDateResponseFromJson(Map<String, dynamic> json) =>
    ReportDateResponse(
      success: json['success'] as bool,
      dateRange: json['date_range'] as String,
      totalHours: (json['total_hours'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ReportDateData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportDateResponseToJson(ReportDateResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'date_range': instance.dateRange,
      'total_hours': instance.totalHours,
      'total_amount': instance.totalAmount,
      'data': instance.data,
    };

ReportDateData _$ReportDateDataFromJson(Map<String, dynamic> json) =>
    ReportDateData(
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

Map<String, dynamic> _$ReportDateDataToJson(ReportDateData instance) =>
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
