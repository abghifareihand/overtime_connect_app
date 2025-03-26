// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteReportResponse _$DeleteReportResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteReportResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$DeleteReportResponseToJson(
        DeleteReportResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
