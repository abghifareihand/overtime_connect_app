// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_overtime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculateOvertimeRequest _$CalculateOvertimeRequestFromJson(
        Map<String, dynamic> json) =>
    CalculateOvertimeRequest(
      monthlySalary: (json['monthly_salary'] as num).toDouble(),
      dayType: json['day_type'] as String,
      workingDays: (json['working_days'] as num).toInt(),
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
    );

Map<String, dynamic> _$CalculateOvertimeRequestToJson(
        CalculateOvertimeRequest instance) =>
    <String, dynamic>{
      'monthly_salary': instance.monthlySalary,
      'day_type': instance.dayType,
      'working_days': instance.workingDays,
      'overtime_hours': instance.overtimeHours,
    };

CalculateOvertimeResponse _$CalculateOvertimeResponseFromJson(
        Map<String, dynamic> json) =>
    CalculateOvertimeResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      overtimeDetails: (json['overtime_details'] as List<dynamic>)
          .map((e) => OvertimeDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalculateOvertimeResponseToJson(
        CalculateOvertimeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
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
