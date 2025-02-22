import 'package:json_annotation/json_annotation.dart';

part 'update_photo_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePhotoResponse {
  UpdatePhotoResponse({
    required this.status,
    required this.message,
    required this.photo,
  });

  factory UpdatePhotoResponse.fromJson(Map<String, dynamic> json) => _$UpdatePhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePhotoResponseToJson(this);

  final String status;
  final String message;
  final String photo;
}
