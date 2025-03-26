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
  final TextEditingController usernameoremailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isCheckbox = false;

  final AuthApi authApi;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    await getInit();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    usernameoremailController.dispose();
    passwordController.dispose();
    super.disposeModel();
  }

  bool get isFormValid {
    return usernameoremailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void toggleCheckbox(bool value) {
    isCheckbox = value;
    notifyListeners();
  }

  void updateUsername(String value) {
    usernameoremailController.text = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  // Fungsi terpisah untuk mendapatkan data dari SharedPreferences
  Future<void> getInit() async {
    final savedUsername = await PrefService.getUsername();
    final savedPassword = await PrefService.getPassword();
    if (savedUsername != null) {
      usernameoremailController.text = savedUsername;
    }
    if (savedPassword != null) {
      passwordController.text = savedPassword;
    }
  }

  Future<void> login({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final LoginRequest loginRequest = LoginRequest(
        login: usernameoremailController.text,
        password: passwordController.text,
      );
      final HttpResponse<LoginResponse> loginResponse = await authApi.login(
        request: loginRequest,
      );
      log('Login Response: ${loginResponse.response.statusCode} - ${loginResponse.data.toJson()}');
      if (loginResponse.response.statusCode == 200) {
        final result = loginResponse.data;
        await PrefService.saveToken(result.token);
        // Simpan username dan password hanya jika checkbox dicentang
        if (isCheckbox) {
          await PrefService.saveUsername(usernameoremailController.text);
          await PrefService.savePassword(passwordController.text);
        }
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
