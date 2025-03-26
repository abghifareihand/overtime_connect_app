import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/reset_password_model.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/dio.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  ForgotPasswordViewModel({
    required this.authApi,
  });
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  int index = 1;
  final AuthApi authApi;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.disposeModel();
  }

  bool get isFormOtpValid {
    return emailController.text.isNotEmpty;
  }

  bool get isFormResetValid {
    return otpController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordConfirmController.text.isNotEmpty;
  }

  bool get isPasswordMatch {
    return passwordController.text == passwordConfirmController.text;
  }

  void updateEmail(String value) {
    emailController.text = value;
    notifyListeners();
  }

  void updateOtp(String value) {
    otpController.text = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  void updatePasswordConfirm(String value) {
    passwordConfirmController.text = value;
    notifyListeners();
  }

  void setToNextTab() {
    index++;
    notifyListeners();
  }

  void setToPrevTab() {
    index--;
    notifyListeners();
  }

  Future<void> requestOtp({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final ResetOtpRequest resetOtpRequest = ResetOtpRequest(
        email: emailController.text,
      );
      final HttpResponse<ResetOtpResponse> resetOtpResponse = await authApi.requestOtp(
        request: resetOtpRequest,
      );
      log('Request Otp Response: ${resetOtpResponse.response.statusCode} - ${resetOtpResponse.data.toJson()}');
      if (resetOtpResponse.response.statusCode == 200) {
        final result = resetOtpResponse.data;
        success(result.message);
      } else {
        final result = resetOtpResponse.data;
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

  Future<void> resetPassword({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final ResetPasswordRequest resetOtpRequest = ResetPasswordRequest(
        email: emailController.text,
        otp: otpController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmController.text,
      );
      final HttpResponse<ResetPasswordResponse> resetPasswordResponse = await authApi.resetPassword(
        request: resetOtpRequest,
      );
      log('Reset Password Response: ${resetPasswordResponse.response.statusCode} - ${resetPasswordResponse.data.toJson()}');
      if (resetPasswordResponse.response.statusCode == 200) {
        final result = resetPasswordResponse.data;
        success(result.message);
      } else {
        final result = resetPasswordResponse.data;
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
