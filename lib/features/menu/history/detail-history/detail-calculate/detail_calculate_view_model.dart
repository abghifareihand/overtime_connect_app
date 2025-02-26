import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/report_detail_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class DetailCalculateViewModel extends BaseViewModel {
  DetailCalculateViewModel({
    required this.overtimeApi,
    required this.calculateId,
  });

  final int calculateId;
  final OvertimeApi overtimeApi;

  ReportDetailResponse? reportDetail;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    await getDetailCalculate(calculateId);
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> getDetailCalculate(int calculateId) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<ReportDetailResponse> reportDetailResponse = await overtimeApi.getReportDetail(
        bearerToken: 'Bearer $token',
        id: calculateId,
      );
      log('Get Detail Calculate Response: ${reportDetailResponse.response.statusCode} - ${reportDetailResponse.data.toJson()}');
      if (reportDetailResponse.response.statusCode == 200) {
        reportDetail = reportDetailResponse.data;
        notifyListeners();
      } else {
        final result = reportDetailResponse.data;
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
