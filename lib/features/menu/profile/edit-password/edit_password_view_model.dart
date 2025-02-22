import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/update_password_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class EditPasswordViewModel extends BaseViewModel {
  EditPasswordViewModel({
    required this.user,
    required this.authApi,
  });

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmationController = TextEditingController();

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

  Future<void> updatePassword({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        newPasswordConfirmation: newPasswordConfirmationController.text,
      );
      final HttpResponse<UpdatePasswordResponse> updatePasswordResponse = await authApi.updatePassword(
        bearerToken: 'Bearer $token',
        request: updatePasswordRequest,
      );
      log('Update Password Response: ${updatePasswordResponse.response.statusCode} - ${updatePasswordResponse.data.toJson()}');
      if (updatePasswordResponse.response.statusCode == 200) {
        final result = updatePasswordResponse.data;
        success(result.message);
      } else {
        final errorMessage = updatePasswordResponse.response.data['message'];
        error(errorMessage);
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
