import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/delete_report_model.dart';
import 'package:overtime_connect_app/core/models/report_date_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class HistoryViewModel extends BaseViewModel {
  HistoryViewModel({
    required this.authApi,
    required this.overtimeApi,
  });

  final AuthApi authApi;
  final OvertimeApi overtimeApi;

  ReportDateResponse? reportDate;
  DeleteReportResponse? deleteReport;
  String? startDate;
  String? endDate;
  String? dateRange;
  double? salary;
  double? overtimeHours;
  double? overtimeAmount;
  int selectedIndex = 0;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    await getUser();
    await getReportDateInit();
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

  void setDateRange(DateTime start, DateTime end) {
    startDate = start.toIso8601String();
    endDate = end.toIso8601String();
    notifyListeners();
  }

  // Untuk total salary (gaji pokok + lemburan)
  double get totalSalary => (salary ?? 0) + (overtimeAmount ?? 0);

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

  Future<void> getReportDate() async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<ReportDateResponse> reportDateResponse =
          await overtimeApi.getReportDateRange(
        bearerToken: 'Bearer $token',
        startDate: startDate,
        endDate: endDate,
      );
      log('Get Report Date Range Response: ${reportDateResponse.response.statusCode} - ${reportDateResponse.data.toJson()}');
      if (reportDateResponse.response.statusCode == 200) {
        reportDate = reportDateResponse.data;
        overtimeHours = reportDateResponse.data.totalHours;
        overtimeAmount = reportDateResponse.data.totalAmount;
        dateRange = reportDateResponse.data.dateRange;
        notifyListeners();
      } else {
        log('Error get report date range');
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

  Future<void> getReportDateInit() async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<ReportDateResponse> reportDateResponse =
          await overtimeApi.getReportDateRange(
        bearerToken: 'Bearer $token',
      );
      log('Get Report Date Range Response: ${reportDateResponse.response.statusCode} - ${reportDateResponse.data.toJson()}');
      if (reportDateResponse.response.statusCode == 200) {
        reportDate = reportDateResponse.data;
        overtimeHours = reportDateResponse.data.totalHours;
        overtimeAmount = reportDateResponse.data.totalAmount;
        dateRange = reportDateResponse.data.dateRange;
        parseDateRange(dateRange);
        notifyListeners();
      } else {
        log('Error get report date range');
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

  Future<void> deleteReportDate(
    int reportId, {
    required Function(String) success,
    required Function(String) error,
  }) async {
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<DeleteReportResponse> deleteReportResponse =
          await overtimeApi.deleteReportById(
        bearerToken: 'Bearer $token',
        id: reportId,
      );
      log('Delete Reporte Response: ${deleteReportResponse.response.statusCode} - ${deleteReportResponse.data.toJson()}');
      if (deleteReportResponse.response.statusCode == 200) {
        final result = deleteReportResponse.data;
        success(result.message);
      } else {
        final result = deleteReportResponse.data;
        error(result.message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        log('Server error: A server error occurred. Please try again later.');
      } else {
        log('API Error: ${e.response?.data['message'] ?? 'An error occurred.'}');
      }
    }
  }

  void parseDateRange(String? range) {
    if (range == null || range.isEmpty) {
      startDate = DateTime.now().subtract(Duration(days: 7)).toIso8601String();
      endDate = DateTime.now().toIso8601String();
      return;
    }

    final dates = range.split(' - ');
    if (dates.length == 2) {
      startDate = _parseDate(dates[0]).toIso8601String();
      endDate = _parseDate(dates[1]).toIso8601String();
    }
  }

// Fungsi bantu untuk konversi string "dd/MM/yyyy" ke DateTime
  DateTime _parseDate(String dateStr) {
    return DateFormat("dd/MM/yyyy").parse(dateStr);
  }

  DateTime? get selectedStartDate => startDate != null ? DateTime.parse(startDate!) : null;
  DateTime? get selectedEndDate => endDate != null ? DateTime.parse(endDate!) : null;
}
