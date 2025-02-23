// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_salary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSalaryRequest _$UpdateSalaryRequestFromJson(Map<String, dynamic> json) =>
    UpdateSalaryRequest(
      salary: (json['salary'] as num).toDouble(),
      password: json['password'] as String,
    );

Map<String, dynamic> _$UpdateSalaryRequestToJson(
        UpdateSalaryRequest instance) =>
    <String, dynamic>{
      'salary': instance.salary,
      'password': instance.password,
    };

UpdateSalaryResponse _$UpdateSalaryResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateSalaryResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      salary: (json['salary'] as num).toDouble(),
    );

Map<String, dynamic> _$UpdateSalaryResponseToJson(
        UpdateSalaryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'salary': instance.salary,
    };
