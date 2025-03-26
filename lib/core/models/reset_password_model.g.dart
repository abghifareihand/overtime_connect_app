// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetOtpRequest _$ResetOtpRequestFromJson(Map<String, dynamic> json) =>
    ResetOtpRequest(
      email: json['email'] as String,
    );

Map<String, dynamic> _$ResetOtpRequestToJson(ResetOtpRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

ResetOtpResponse _$ResetOtpResponseFromJson(Map<String, dynamic> json) =>
    ResetOtpResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ResetOtpResponseToJson(ResetOtpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequest(
      email: json['email'] as String,
      otp: json['otp'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };

ResetPasswordResponse _$ResetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ResetPasswordResponseToJson(
        ResetPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
