import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/models/api_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel({
    required this.authApi,
  });

  final AuthApi authApi;
  User? user;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    await getUser();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> getUser() async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<UserResponse> userResponse = await authApi.getUser(
        bearerToken: 'Bearer $token',
      );
      log('Get User Response: ${userResponse.response.statusCode} - ${userResponse.data.toJson()}');
      if (userResponse.response.statusCode == 200) {
        user = userResponse.data.user;
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

  Future<void> logout({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<ApiResponse> logoutResponse = await authApi.logout(
        bearerToken: 'Bearer $token',
      );
      log('Logout Response: ${logoutResponse.response.statusCode} - ${logoutResponse.data.toJson()}');
      if (logoutResponse.response.statusCode == 200) {
        final result = logoutResponse.data;
        await PrefService.logout();
        success(result.message);
      } else {
        final result = logoutResponse.data;
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
