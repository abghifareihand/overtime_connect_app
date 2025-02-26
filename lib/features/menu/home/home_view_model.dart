import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/report_model.dart';
import 'package:overtime_connect_app/core/models/report_monthly_model.dart';
import 'package:overtime_connect_app/core/models/report_weekly_model.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:overtime_connect_app/features/menu/home/widgets/report_chart_widget.dart';
import 'package:retrofit/retrofit.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required this.authApi,
    required this.overtimeApi,
  });

  final AuthApi authApi;
  final OvertimeApi overtimeApi;
  User? user;
  ReportResponse? report;
  String? monthOvertime;
  double? hoursOvertime;
  double? totalOvertime;

  ReportWeeklyResponse? reportWeekly;
  ReportMonthlyResponse? reportMonthly;
  List<ChartData> weeklyChartData = [];
  Map<DateTime, List<ReportMonthlyData>> overtimeData = {};
  String selectedReport = 'Mingguan';
  bool isLoading = true;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    await getUser();
    await getReport();
    await initReportView();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  void updateSelectedReport(String newView) {
    selectedReport = newView;
    notifyListeners();

    // Fetch the corresponding data based on the selected view
    if (selectedReport == 'Mingguan') {
      getReportWeekly(); // Fetch weekly report data
    } else {
      getReportMonthly(); // Fetch monthly report data
    }
  }

  Future<void> initReportView() async {
    selectedReport = 'Mingguan'; // Default to "Mingguan"
    await getReportMonthly();
    await getReportWeekly(); // Fetch weekly data initially
    notifyListeners();
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

  Future<void> getReport() async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';

      // Ambil bulan dan tahun saat ini
      final String currentMonth = DateTime.now().month.toString().padLeft(2, '0');
      final String currentYear = DateTime.now().year.toString();
      final HttpResponse<ReportResponse> reportResponse = await overtimeApi.getReport(
        bearerToken: 'Bearer $token',
        month: currentMonth,
        year: currentYear,
      );
      log('Get Report Response: ${reportResponse.response.statusCode} - ${reportResponse.data.toJson()}');
      if (reportResponse.response.statusCode == 200) {
        report = reportResponse.data;
        monthOvertime = reportResponse.data.month;
        hoursOvertime = reportResponse.data.totalHours;
        totalOvertime = reportResponse.data.totalAmount;
        report = reportResponse.data;
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

  Future<void> getReportWeekly() async {
    isLoading = true;
    notifyListeners();
    try {
      final String token = await PrefService.getToken() ?? '';
      final HttpResponse<ReportWeeklyResponse> reportResponse = await overtimeApi.getReportWeekly(
        bearerToken: 'Bearer $token',
      );
      log('Get Weekly Report Response: ${reportResponse.response.statusCode} - ${reportResponse.data.toJson()}');

      if (reportResponse.response.statusCode == 200) {
        reportWeekly = reportResponse.data;
        // Mapping data API ke ChartData
        Map<String, double> overtimeByDay = {
          "Sen": 0,
          "Sel": 0,
          "Rab": 0,
          "Kam": 0,
          "Jum": 0,
          "Sab": 0,
          "Min": 0,
        };
        String convertDateToDay(DateTime date) {
          const List<String> days = ["Min", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"];
          return days[date.weekday % 7]; // Sesuai format dari API
        }

        for (var report in reportWeekly!.data) {
          DateTime date = DateTime.parse(report.date);
          String day = convertDateToDay(date);
          overtimeByDay[day] = (overtimeByDay[day] ?? 0) + report.overtimeHours;
        }

        // Convert ke List<ChartData>
        weeklyChartData = overtimeByDay.entries.map((entry) {
          return ChartData(entry.key, entry.value); // Biarkan nilai tetap double
        }).toList();

        notifyListeners();
      } else {
        log('Error: ${reportResponse.data.status}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        log('Server error: A server error occurred. Please try again later.');
      } else {
        log('API Error: ${e.response?.data['message'] ?? 'An error occurred.'}');
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getReportMonthly() async {
    isLoading = true;
    notifyListeners();
    try {
      final String token = await PrefService.getToken() ?? '';
      // Ambil bulan dan tahun saat ini
      final String currentMonth = DateTime.now().month.toString().padLeft(2, '0');
      final String currentYear = DateTime.now().year.toString();
      final HttpResponse<ReportMonthlyResponse> reportResponse = await overtimeApi.getReportMonthly(
        bearerToken: 'Bearer $token',
        month: currentMonth,
        year: currentYear,
      );
      log('Get Monthly Report Response: ${reportResponse.response.statusCode} - ${reportResponse.data.toJson()}');
      if (reportResponse.response.statusCode == 200) {
        reportMonthly = reportResponse.data;

        overtimeData = {};
        for (var report in reportMonthly!.data) {
          final date = DateTime.parse(report.date); // Parsing string menjadi DateTime
          if (overtimeData[date] == null) {
            overtimeData[date] = [];
          }
          overtimeData[date]?.add(report); // Menambahkan laporan lembur ke tanggal tersebut
        }
        notifyListeners();
      } else {
        log('Error: ${reportResponse.data.status}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        log('Server error: A server error occurred. Please try again later.');
      } else {
        log('API Error: ${e.response?.data['message'] ?? 'An error occurred.'}');
      }
    }
    isLoading = false;
    notifyListeners();
  }

  bool hasOvertime(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return overtimeData.containsKey(normalizedDay) && overtimeData[normalizedDay]?.isNotEmpty == true;
  }

  // Fungsi untuk memeriksa apakah lembur berstatus 0 (disable)
  bool isOvertimeDisabled(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    var overtimeReports = overtimeData[normalizedDay];

    if (overtimeReports != null && overtimeReports.isNotEmpty) {
      for (var report in overtimeReports) {
        if (report.status == 0) {
          // Jika status = 0, berarti disable
          return true;
        }
      }
    }

    return false; // Status bukan 0, berarti tidak disable
  }

  bool isToday(DateTime day) {
    return day.year == DateTime.now().year && day.month == DateTime.now().month && day.day == DateTime.now().day;
  }

  String getOvertimeText(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    var overtimeReports = overtimeData[normalizedDay];

    if (overtimeReports != null && overtimeReports.isNotEmpty) {
      for (var report in overtimeReports) {
        if (report.status == 1) {
          // Jika overtimeHours adalah angka bulat, tampilkan tanpa desimal
          double overtimeHours = report.overtimeHours;
          if (overtimeHours == overtimeHours.toInt()) {
            // Jika overtimeHours adalah bilangan bulat, tampilkan sebagai integer
            return '${overtimeHours.toInt()} Jam';
          } else {
            // Jika overtimeHours memiliki desimal, tampilkan hanya satu angka di belakang koma
            return '${overtimeHours.toStringAsFixed(1)} Jam';
          }
        }
      }
    }

    return ''; // Tidak ada lembur pada tanggal ini
  }
}
