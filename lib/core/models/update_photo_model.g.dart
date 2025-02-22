// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePhotoResponse _$UpdatePhotoResponseFromJson(Map<String, dynamic> json) =>
    UpdatePhotoResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$UpdatePhotoResponseToJson(
        UpdatePhotoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'photo': instance.photo,
    };
