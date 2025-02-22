// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overtime_years_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OvertimeYearsResponse _$OvertimeYearsResponseFromJson(
        Map<String, dynamic> json) =>
    OvertimeYearsResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      years: (json['years'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OvertimeYearsResponseToJson(
        OvertimeYearsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'years': instance.years,
    };
