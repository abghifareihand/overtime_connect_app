import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/register_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/dio.dart';

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel({
    required this.authApi,
  });
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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
    fullnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    salaryController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.disposeModel();
  }

  bool get isFormValid {
    return isCheckbox && fullnameController.text.isNotEmpty && usernameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty && salaryController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty;
  }

  bool get isPasswordMatch {
    return passwordController.text == confirmPasswordController.text;
  }

  void toggleCheckbox(bool value) {
    isCheckbox = value;
    notifyListeners();
  }

  void updateFullname(String value) {
    fullnameController.text = value;
    notifyListeners();
  }

  void updateUsername(String value) {
    usernameController.text = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    emailController.text = value;
    notifyListeners();
  }

  void updatePhone(String value) {
    phoneController.text = value;
    notifyListeners();
  }

  String formatCurrency(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedValue.isEmpty) return '0';

    final numberFormat = NumberFormat("#,###", "id_ID");
    return numberFormat.format(int.parse(cleanedValue));
  }

  void updateSalary(String value) {
    final formatted = formatCurrency(value);
    salaryController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    notifyListeners();
  }

  void updatePassword(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    confirmPasswordController.text = value;
    notifyListeners();
  }

  Future<void> register({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final cleanedSalary = salaryController.text.replaceAll('.', '');
      final RegisterRequest registerRequest = RegisterRequest(
        fullname: fullnameController.text,
        email: emailController.text,
        username: usernameController.text,
        phone: phoneController.text,
        salary: double.parse(cleanedSalary),
        password: passwordController.text,
      );
      final HttpResponse<RegisterResponse> registerResponse = await authApi.register(
        request: registerRequest,
      );
      log('Register Response: ${registerResponse.response.statusCode} - ${registerResponse.data.toJson()}');
      if (registerResponse.response.statusCode == 201) {
        final result = registerResponse.data;
        await PrefService.saveToken(result.token);
        success(result.message);
      } else {
        final result = registerResponse.data;
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
