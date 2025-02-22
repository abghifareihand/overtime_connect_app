import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/day_type_model.dart';
import 'package:overtime_connect_app/core/models/overtime_model.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';
import 'package:retrofit/dio.dart';
import 'package:intl/intl.dart';

class AbsenViewModel extends BaseViewModel {
  AbsenViewModel({
    required this.overtimeApi,
    required this.salary,
    required this.workingDays,
  });

  final TextEditingController dateAbsentController = TextEditingController();
  final TextEditingController dateNotPresentController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  int selectedIndex = 0;

  final OvertimeApi overtimeApi;
  final double salary;
  final int workingDays;

  // String? selectedDayType;
  // final List<String> dayTypes = [
  //   'Regular',
  //   'Holiday',
  // ];

  // void updateDayType(String newDayType) {
  //   selectedDayType = newDayType;
  //   notifyListeners();
  // }

  DayType? selectedDayType;

  final List<DayType> dayTypes = [
    DayType(id: 'regular', title: 'Hari Biasa'),
    DayType(id: 'holiday', title: 'Hari Libur'),
  ];

  void updateDayType(DayType newDayType) {
    selectedDayType = newDayType;
    notifyListeners();
  }

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    dateAbsentController.dispose();
    dateNotPresentController.dispose();
    hoursController.dispose();
    totalController.dispose();
    super.disposeModel();
  }

  bool get isFormValidAbsent {
    return dateAbsentController.text.isNotEmpty && hoursController.text.isNotEmpty && totalController.text.isEmpty;
  }

  bool get isFormValidNotPresent {
    return dateNotPresentController.text.isNotEmpty;
  }

  void onTabSelected(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateDateAbsent(DateTime selectedDate) {
    dateAbsentController.text = selectedDate.toFormattedDate();
    notifyListeners();
  }

  void updateHours(String hours) {
    hoursController.text = hours;
    notifyListeners();
  }

  void updateDateNotPresent(DateTime selectedDate) {
    dateNotPresentController.text = selectedDate.toFormattedDate();
    notifyListeners();
  }

  Future<void> addOvertimeAbsent({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      DateTime parsedDate = dateFormat.parse(dateAbsentController.text);

      // Mengambil jam lembur yang dimasukkan
      double overtimeHours = double.tryParse(hoursController.text) ?? 0.0;

      // Menghitung total lembur berdasarkan tipe hari
      double totalOvertime = overtimeHours.calculateOvertime(salary, selectedDayType?.id ?? '', workingDays);
      final AddOvertimeRequest addOvertimeRequest = AddOvertimeRequest(
        date: parsedDate.toApiFormattedDate(),
        overtimeHours: double.parse(hoursController.text),
        totalOvertime: totalOvertime.roundToDouble(),
        status: 1,
        dayType: selectedDayType!.id,
      );
      log('Request Data: ${addOvertimeRequest.toJson()}');
      final HttpResponse<AddOvertimeResponse> addOvertimeResponse = await overtimeApi.addOvertime(
        bearerToken: 'Bearer $token',
        request: addOvertimeRequest,
      );
      log('Login Response: ${addOvertimeResponse.response.statusCode} - ${addOvertimeResponse.data.toJson()}');
      if (addOvertimeResponse.response.statusCode == 201) {
        final result = addOvertimeResponse.data;
        success(result.message);
      } else {
        final result = addOvertimeResponse.data;
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

  Future<void> addOvertimeNotPresent({
    required Function(String) success,
    required Function(String) error,
  }) async {
    setBusy(true);
    try {
      final String token = await PrefService.getToken() ?? '';
      final AddOvertimeRequest addOvertimeRequest = AddOvertimeRequest(
        date: DateTime.now().toApiFormattedDate(),
        overtimeHours: 0,
        totalOvertime: 0,
        status: 0,
        dayType: 'regular',
      );
      log('Request Data: ${addOvertimeRequest.toJson()}');
      final HttpResponse<AddOvertimeResponse> addOvertimeResponse = await overtimeApi.addOvertime(
        bearerToken: 'Bearer $token',
        request: addOvertimeRequest,
      );
      log('Login Response: ${addOvertimeResponse.response.statusCode} - ${addOvertimeResponse.data.toJson()}');
      if (addOvertimeResponse.response.statusCode == 201) {
        final result = addOvertimeResponse.data;
        success(result.message);
      } else {
        final result = addOvertimeResponse.data;
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
