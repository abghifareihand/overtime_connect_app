import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/day_type_model.dart';
import 'package:overtime_connect_app/core/models/update_profile_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrofit/retrofit.dart';

class EditProfileViewModel extends BaseViewModel {
  EditProfileViewModel({
    required this.user,
    required this.authApi,
  }) {
    fullnameController.text = user.fullname;
    phoneController.text = user.phone;
    salaryController.text = user.salary.toCurrency();
    selectedWorkingDays = workingDays.firstWhere(
      (e) => int.tryParse(e.id) == user.workingDays,
      orElse: () => workingDays.first, // Default ke opsi pertama jika tidak ditemukan
    );
  }

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  final User user;
  final AuthApi authApi;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  WorkingDays? selectedWorkingDays;
  final List<WorkingDays> workingDays = [
    WorkingDays(id: '5', title: '5 Hari Kerja'),
    WorkingDays(id: '6', title: '6 Hari Kerja'),
  ];

  void updateWorkingDays(WorkingDays newWorkingDays) {
    selectedWorkingDays = newWorkingDays;
    notifyListeners();
  }

  File? photoProfile;

  Future<void> pickPhotoProfile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      photoProfile = File(image.path);
      notifyListeners();
    }
  }

  Future<void> cameraPhotoProfile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      photoProfile = File(image.path);
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<UpdateProfileResponse> updateProfileResponse = await authApi.updateProfile(
        bearerToken: 'Bearer $token',
        fullname: fullnameController.text,
        phone: phoneController.text,
        workingDays: int.parse(selectedWorkingDays!.id),
        photo: photoProfile,
      );
      log('Update Profile Response: ${updateProfileResponse.response.statusCode} - ${updateProfileResponse.data.toJson()}');
      if (updateProfileResponse.response.statusCode == 200) {
        final result = updateProfileResponse.data;
        success(result.message);
      } else {
        final result = updateProfileResponse.data;
        error(result.message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        error('A server error occurred. Please try again later.');
      } else {
        error(e.response?.data['message'] ?? 'An error occurred.');
      }
    }
    setBusy(false);
  }
}
