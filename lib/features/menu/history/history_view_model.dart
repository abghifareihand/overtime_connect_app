import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/overtime_years_model.dart';
import 'package:overtime_connect_app/core/models/report_yearly_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class HistoryViewModel extends BaseViewModel {
  HistoryViewModel({
    required this.overtimeApi,
  });

  final OvertimeApi overtimeApi;
  OvertimeYearsResponse? overtimeYears;
  ReportYearlyResponse? reportYearlyResponse;
  String? selectedYears;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    await getYears();
    await getLatestYearReport();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  void updateSelectedYear(String newYear) {
    selectedYears = newYear;
    notifyListeners();
  }

  // Fungsi untuk memilih tahun terakhir dan mengambil laporan tahunan
  Future<void> getLatestYearReport() async {
    if (overtimeYears?.years.isNotEmpty == true) {
      selectedYears = overtimeYears!.years.last;
      notifyListeners();
      await getReportYearly();
    }
  }

  Future<void> getYears() async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<OvertimeYearsResponse> yearResponse = await overtimeApi.getYears(
        bearerToken: 'Bearer $token',
      );
      log('Get Years Response: ${yearResponse.response.statusCode} - ${yearResponse.data.toJson()}');
      if (yearResponse.response.statusCode == 200) {
        overtimeYears = yearResponse.data;
        notifyListeners();
      } else {
        final result = yearResponse.data;
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

  Future<void> getReportYearly() async {
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<ReportYearlyResponse> reportResponse = await overtimeApi.getReportYearly(
        bearerToken: 'Bearer $token',
        year: selectedYears,
      );
      log('Get Report Yearly Response: ${reportResponse.response.statusCode} - ${reportResponse.data.toJson()}');
      if (reportResponse.response.statusCode == 200) {
        reportYearlyResponse = reportResponse.data;
        notifyListeners();
      } else {
        log('Error Report Yearly: ${reportResponse.data.status}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        log('Server error: A server error occurred. Please try again later.');
      } else {
        log('API Error: ${e.response?.data['message'] ?? 'An error occurred.'}');
      }
    }
  }
}
