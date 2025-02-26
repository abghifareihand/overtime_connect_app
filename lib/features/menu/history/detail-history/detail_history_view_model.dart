import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/report_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class DetailHistoryViewModel extends BaseViewModel {
  DetailHistoryViewModel({
    required this.authApi,
    required this.overtimeApi,
    required this.detailMonth,
    required this.detailYear,
  });

  final AuthApi authApi;
  final OvertimeApi overtimeApi;
  final String detailMonth;
  final String detailYear;

  ReportResponse? report;
  String? month;
  String? year;
  double? salary;
  double? overtime;
  int selectedIndex = 0;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    await getUser();
    await getReport();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  void onTabSelected(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // Untuk total salary (gaji pokok + lemburan)
  double get totalSalary => (salary ?? 0) + (overtime ?? 0);

  Future<void> getUser() async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<UserResponse> userResponse = await authApi.getUser(
        bearerToken: 'Bearer $token',
      );
      log('Get User Response: ${userResponse.response.statusCode} - ${userResponse.data.toJson()}');
      if (userResponse.response.statusCode == 200) {
        salary = userResponse.data.user.salary;
        notifyListeners();
      } else {
        final result = userResponse.data;
        log('Error: ${result.message}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        log('Server error: A server error occurred. Please try again later.');
      } else {
        log('API Error: ${e.response?.data['message'] ?? 'An error occurred.'}');
      }
    }
    setBusy(false);
  }

  Future<void> getReport() async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<ReportResponse> reportResponse = await overtimeApi.getReport(
        bearerToken: 'Bearer $token',
        month: detailMonth,
        year: detailYear,
      );
      log('Get Report Response: ${reportResponse.response.statusCode} - ${reportResponse.data.toJson()}');
      if (reportResponse.response.statusCode == 200) {
        report = reportResponse.data;
        month = reportResponse.data.month;
        year = reportResponse.data.year;
        overtime = reportResponse.data.totalAmount;
        notifyListeners();
      } else {
        final result = reportResponse.data;
        log('Error: ${result.message}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        log('Server error: A server error occurred. Please try again later.');
      } else {
        log('API Error: ${e.response?.data['message'] ?? 'An error occurred.'}');
      }
    }
    setBusy(false);
  }
}
