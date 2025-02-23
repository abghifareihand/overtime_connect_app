import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/get_calculate_model.dart';
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

  GetCalculateDetailResponse? calculateDetail;

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
      final HttpResponse<GetCalculateDetailResponse> detailCalculateResponse = await overtimeApi.getCalculateDetail(
        bearerToken: 'Bearer $token',
        id: calculateId,
      );
      log('Get Detail Calculate Response: ${detailCalculateResponse.response.statusCode} - ${detailCalculateResponse.data.toJson()}');
      if (detailCalculateResponse.response.statusCode == 200) {
        calculateDetail = detailCalculateResponse.data;
        notifyListeners();
      } else {
        final result = detailCalculateResponse.data;
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
