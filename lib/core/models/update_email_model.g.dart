// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmailRequest _$UpdateEmailRequestFromJson(Map<String, dynamic> json) =>
    UpdateEmailRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UpdateEmailRequestToJson(UpdateEmailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

UpdateEmailResponse _$UpdateEmailResponseFromJson(Map<String, dynamic> json) =>
    UpdateEmailResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UpdateEmailResponseToJson(
        UpdateEmailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'email': instance.email,
    };
