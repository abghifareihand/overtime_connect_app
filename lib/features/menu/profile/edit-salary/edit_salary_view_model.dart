import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/update_salary_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class EditSalaryViewModel extends BaseViewModel {
  EditSalaryViewModel({
    required this.salary,
    required this.authApi,
  });

  final TextEditingController salaryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final double salary;
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
    return salaryController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void updatePasswordField(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  // Format angka dengan titik dan rupiah (contoh: Rp. 5.000.000)
  String formatCurrencyRupiah(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), ''); // Hanya angka
    if (cleanedValue.isEmpty) return '';

    final numberFormat = NumberFormat("#,###", "id_ID");
    return "Rp. ${numberFormat.format(int.parse(cleanedValue))}";
  }

  // Update text field salary agar otomatis memformat tampilan
  void onSalaryChanged(String value) {
    String formatted = formatCurrencyRupiah(value);
    salaryController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    notifyListeners();
  }

  Future<void> updateSalary({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final double salary = double.parse(salaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));
      final UpdateSalaryRequest updateSalaryRequest = UpdateSalaryRequest(
        salary: salary,
        password: passwordController.text,
      );
      log('Request to update salary: ${updateSalaryRequest.toJson()}');
      final HttpResponse<UpdateSalaryResponse> updateSalaryResponse = await authApi.updateSalary(
        bearerToken: 'Bearer $token',
        request: updateSalaryRequest,
      );
      log('Update Email Response: ${updateSalaryResponse.response.statusCode} - ${updateSalaryResponse.data.toJson()}');
      if (updateSalaryResponse.response.statusCode == 200) {
        final result = updateSalaryResponse.data;
        success(result.message);
      } else {
        final result = updateSalaryResponse.data;
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
