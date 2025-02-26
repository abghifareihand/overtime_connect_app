// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overtime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOvertimeRequest _$AddOvertimeRequestFromJson(Map<String, dynamic> json) =>
    AddOvertimeRequest(
      date: json['date'] as String,
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      dayType: json['day_type'] as String,
      overtimeDetails: (json['overtime_details'] as List<dynamic>)
          .map((e) => OvertimeDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddOvertimeRequestToJson(AddOvertimeRequest instance) =>
    <String, dynamic>{
      'date': instance.date,
      'overtime_hours': instance.overtimeHours,
      'total_overtime': instance.totalOvertime,
      'status': instance.status,
      'day_type': instance.dayType,
      'overtime_details': instance.overtimeDetails,
    };

AddOvertimeResponse _$AddOvertimeResponseFromJson(Map<String, dynamic> json) =>
    AddOvertimeResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: OvertimeData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddOvertimeResponseToJson(
        AddOvertimeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

OvertimeData _$OvertimeDataFromJson(Map<String, dynamic> json) => OvertimeData(
      userId: (json['user_id'] as num).toInt(),
      date: json['date'] as String,
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
      totalOvertime: (json['total_overtime'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      updatedAt: json['updated_at'] as String,
      createdAt: json['created_at'] as String,
      id: (json['id'] as num).toInt(),
      dayType: json['day_type'] as String,
    );

Map<String, dynamic> _$OvertimeDataToJson(OvertimeData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'date': instance.date,
      'overtime_hours': instance.overtimeHours,
      'total_overtime': instance.totalOvertime,
      'status': instance.status,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
      'day_type': instance.dayType,
    };
