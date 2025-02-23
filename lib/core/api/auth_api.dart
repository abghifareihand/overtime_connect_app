import 'dart:io';

import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/models/login_model.dart';
import 'package:overtime_connect_app/core/models/register_model.dart';
import 'package:overtime_connect_app/core/models/api_model.dart';
import 'package:overtime_connect_app/core/models/update_email_model.dart';
import 'package:overtime_connect_app/core/models/update_password_model.dart';
import 'package:overtime_connect_app/core/models/update_profile_model.dart';
import 'package:overtime_connect_app/core/models/update_salary_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/api/register')
  Future<HttpResponse<RegisterResponse>> register({
    @Body() required RegisterRequest request,
  });

  @POST('/api/login')
  Future<HttpResponse<LoginResponse>> login({
    @Body() required LoginRequest request,
  });

  @GET('/api/user')
  Future<HttpResponse<UserResponse>> getUser({
    @Header('Authorization') required String bearerToken,
  });

  @POST('/api/user/profile')
  @MultiPart()
  Future<HttpResponse<UpdateProfileResponse>> updateProfile({
    @Header('Authorization') required String bearerToken,
    @Part(name: 'fullname') required String fullname,
    @Part(name: 'phone') required String phone,
    @Part(name: 'working_days') required int workingDays,
    @Part(name: 'photo') File? photo,
  });

  @POST('/api/user/email')
  Future<HttpResponse<UpdateEmailResponse>> updateEmail({
    @Header('Authorization') required String bearerToken,
    @Body() required UpdateEmailRequest request,
  });

  @POST('/api/user/salary')
  Future<HttpResponse<UpdateSalaryResponse>> updateSalary({
    @Header('Authorization') required String bearerToken,
    @Body() required UpdateSalaryRequest request,
  });

  @POST('/api/user/password')
  Future<HttpResponse<UpdatePasswordResponse>> updatePassword({
    @Header('Authorization') required String bearerToken,
    @Body() required UpdatePasswordRequest request,
  });

  @POST('/api/logout')
  Future<HttpResponse<ApiResponse>> logout({
    @Header('Authorization') required String bearerToken,
  });
}
