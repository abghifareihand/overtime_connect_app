import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/update_email_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class EditEmailViewModel extends BaseViewModel {
  EditEmailViewModel({
    required this.user,
    required this.authApi,
  }) {
    emailController.text = user.email;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  bool get isFormValid {
    return emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void updateEmailField(String value) {
    emailController.text = value;
    notifyListeners();
  }

  void updatePasswordField(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  Future<void> updateEmail({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final UpdateEmailRequest updateEmailRequest = UpdateEmailRequest(
        email: emailController.text,
        password: passwordController.text,
      );
      final HttpResponse<UpdateEmailResponse> updateEmailResponse = await authApi.updateEmail(
        bearerToken: 'Bearer $token',
        request: updateEmailRequest,
      );
      log('Update Email Response: ${updateEmailResponse.response.statusCode} - ${updateEmailResponse.data.toJson()}');
      if (updateEmailResponse.response.statusCode == 200) {
        final result = updateEmailResponse.data;
        success(result.message);
      } else {
        final result = updateEmailResponse.data;
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
