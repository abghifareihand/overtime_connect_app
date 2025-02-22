// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileResponse _$UpdateProfileResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateProfileResponseToJson(
        UpdateProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user,
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      fullname: json['fullname'] as String,
      phone: json['phone'] as String,
      salary: (json['salary'] as num).toDouble(),
      workingDays: (json['working_days'] as num).toInt(),
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'phone': instance.phone,
      'salary': instance.salary,
      'working_days': instance.workingDays,
      'photo': instance.photo,
    };
