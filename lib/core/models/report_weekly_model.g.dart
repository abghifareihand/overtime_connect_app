// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_weekly_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportWeeklyResponse _$ReportWeeklyResponseFromJson(
        Map<String, dynamic> json) =>
    ReportWeeklyResponse(
      status: json['status'] as String,
      weekStart: json['week_start'] as String,
      weekEnd: json['week_end'] as String,
      totalHours: (json['total_hours'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ReportWeeklyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportWeeklyResponseToJson(
        ReportWeeklyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'week_start': instance.weekStart,
      'week_end': instance.weekEnd,
      'total_hours': instance.totalHours,
      'total_amount': instance.totalAmount,
      'data': instance.data,
    };

ReportWeeklyData _$ReportWeeklyDataFromJson(Map<String, dynamic> json) =>
    ReportWeeklyData(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      date: json['date'] as String,
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      dayType: json['day_type'] as String,
    );

Map<String, dynamic> _$ReportWeeklyDataToJson(ReportWeeklyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'overtime_hours': instance.overtimeHours,
      'total_overtime': instance.totalOvertime,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'day_type': instance.dayType,
    };
