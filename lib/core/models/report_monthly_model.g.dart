// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_monthly_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportMonthlyResponse _$ReportMonthlyResponseFromJson(
        Map<String, dynamic> json) =>
    ReportMonthlyResponse(
      status: json['status'] as String,
      monthStart: json['month_start'] as String,
      monthEnd: json['month_end'] as String,
      totalHours: (json['total_hours'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ReportMonthlyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportMonthlyResponseToJson(
        ReportMonthlyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'month_start': instance.monthStart,
      'month_end': instance.monthEnd,
      'total_hours': instance.totalHours,
      'total_amount': instance.totalAmount,
      'data': instance.data,
    };

ReportMonthlyData _$ReportMonthlyDataFromJson(Map<String, dynamic> json) =>
    ReportMonthlyData(
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

Map<String, dynamic> _$ReportMonthlyDataToJson(ReportMonthlyData instance) =>
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
