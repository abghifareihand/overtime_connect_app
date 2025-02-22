import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/login_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/dio.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({
    required this.authApi,
  });
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isCheckbox = false;

  final AuthApi authApi;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    usernameController.dispose();
    passwordController.dispose();
    super.disposeModel();
  }

  bool get isFormValid {
    return isCheckbox && usernameController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void toggleCheckbox(bool value) {
    isCheckbox = value;
    notifyListeners();
  }

  void updateUsername(String value) {
    usernameController.text = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  Future<void> login({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final LoginRequest loginRequest = LoginRequest(
        username: usernameController.text,
        password: passwordController.text,
      );
      final HttpResponse<LoginResponse> loginResponse = await authApi.login(
        request: loginRequest,
      );
      log('Login Response: ${loginResponse.response.statusCode} - ${loginResponse.data.toJson()}');
      if (loginResponse.response.statusCode == 200) {
        final result = loginResponse.data;
        await PrefService.saveToken(result.token);
        success(result.message);
      } else {
        final result = loginResponse.data;
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
