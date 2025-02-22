// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_yearly_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportYearlyResponse _$ReportYearlyResponseFromJson(
        Map<String, dynamic> json) =>
    ReportYearlyResponse(
      status: json['status'] as String,
      year: json['year'] as String,
      totalHours: (json['total_hours'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, ReportYearlyMonthData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ReportYearlyResponseToJson(
        ReportYearlyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'year': instance.year,
      'total_hours': instance.totalHours,
      'total_amount': instance.totalAmount,
      'data': instance.data,
    };

ReportYearlyMonthData _$ReportYearlyMonthDataFromJson(
        Map<String, dynamic> json) =>
    ReportYearlyMonthData(
      month: json['month'] as String,
      totalHours: (json['total_hours'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      overtimes: (json['overtimes'] as List<dynamic>)
          .map((e) => ReportOvertimeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportYearlyMonthDataToJson(
        ReportYearlyMonthData instance) =>
    <String, dynamic>{
      'month': instance.month,
      'total_hours': instance.totalHours,
      'total_amount': instance.totalAmount,
      'overtimes': instance.overtimes,
    };

ReportOvertimeData _$ReportOvertimeDataFromJson(Map<String, dynamic> json) =>
    ReportOvertimeData(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      date: json['date'] as String,
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      dayType: json['day_type'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$ReportOvertimeDataToJson(ReportOvertimeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'overtime_hours': instance.overtimeHours,
      'total_overtime': instance.totalOvertime,
      'status': instance.status,
      'day_type': instance.dayType,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
