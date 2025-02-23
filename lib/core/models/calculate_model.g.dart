// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCalculateRequest _$AddCalculateRequestFromJson(Map<String, dynamic> json) =>
    AddCalculateRequest(
      date: json['date'] as String,
      monthlySalary: (json['monthly_salary'] as num).toDouble(),
      dayType: json['day_type'] as String,
      workingDays: (json['working_days'] as num).toInt(),
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
    );

Map<String, dynamic> _$AddCalculateRequestToJson(
        AddCalculateRequest instance) =>
    <String, dynamic>{
      'date': instance.date,
      'monthly_salary': instance.monthlySalary,
      'day_type': instance.dayType,
      'working_days': instance.workingDays,
      'overtime_hours': instance.overtimeHours,
    };

AddCalculateResponse _$AddCalculateResponseFromJson(
        Map<String, dynamic> json) =>
    AddCalculateResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddCalculateResponseToJson(
        AddCalculateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
