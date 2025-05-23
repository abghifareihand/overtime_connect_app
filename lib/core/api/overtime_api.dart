import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/models/calculate_overtime_model.dart';
import 'package:overtime_connect_app/core/models/delete_report_model.dart';
import 'package:overtime_connect_app/core/models/overtime_model.dart';
import 'package:overtime_connect_app/core/models/overtime_years_model.dart';
import 'package:overtime_connect_app/core/models/report_by_id_model.dart';
import 'package:overtime_connect_app/core/models/report_date_model.dart';
import 'package:overtime_connect_app/core/models/report_detail_model.dart';
import 'package:overtime_connect_app/core/models/report_model.dart';
import 'package:overtime_connect_app/core/models/report_monthly_model.dart';
import 'package:overtime_connect_app/core/models/report_weekly_model.dart';
import 'package:overtime_connect_app/core/models/report_yearly_model.dart';
import 'package:retrofit/retrofit.dart';

part 'overtime_api.g.dart';

@RestApi()
abstract class OvertimeApi {
  factory OvertimeApi(Dio dio, {String baseUrl}) = _OvertimeApi;

  @POST('/api/overtime')
  Future<HttpResponse<AddOvertimeResponse>> addOvertime({
    @Header('Authorization') required String bearerToken,
    @Body() required AddOvertimeRequest request,
  });

  @GET('/api/overtime-report')
  Future<HttpResponse<ReportResponse>> getReport({
    @Header('Authorization') required String bearerToken,
    @Query('month') String? month,
    @Query('year') String? year,
  });

  @GET('/api/overtime-years')
  Future<HttpResponse<OvertimeYearsResponse>> getYears({
    @Header('Authorization') required String bearerToken,
  });

  @GET('/api/overtime-report-weekly')
  Future<HttpResponse<ReportWeeklyResponse>> getReportWeekly({
    @Header('Authorization') required String bearerToken,
  });

  @GET('/api/overtime-report-monthly')
  Future<HttpResponse<ReportMonthlyResponse>> getReportMonthly({
    @Header('Authorization') required String bearerToken,
    @Query('month') String? month,
    @Query('year') String? year,
  });

  @GET('/api/overtime-report-yearly')
  Future<HttpResponse<ReportYearlyResponse>> getReportYearly({
    @Header('Authorization') required String bearerToken,
    @Query('year') String? year,
  });

  @GET('/api/overtime-report-date')
  Future<HttpResponse<ReportDateResponse>> getReportDateRange({
    @Header('Authorization') required String bearerToken,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
  });

  @GET('/api/overtime-report/{id}')
  Future<HttpResponse<ReportByIdResponse>> getReportById({
    @Header('Authorization') required String bearerToken,
    @Path('id') required int id,
  });

  @DELETE('/api/overtime/{id}')
  Future<HttpResponse<DeleteReportResponse>> deleteReportById({
    @Header('Authorization') required String bearerToken,
    @Path('id') required int id,
  });

  @GET('/api/overtime-report/{id}/details')
  Future<HttpResponse<ReportDetailResponse>> getReportDetail({
    @Header('Authorization') required String bearerToken,
    @Path('id') required int id,
  });

  @POST('/api/calculate-overtime')
  Future<HttpResponse<CalculateOvertimeResponse>> getCalculateOvertime({
    @Body() required CalculateOvertimeRequest request,
  });
}
