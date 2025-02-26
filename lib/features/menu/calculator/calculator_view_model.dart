import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/models/calculate_overtime_model.dart';
import 'package:overtime_connect_app/core/models/day_type_model.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class CalculatorViewModel extends BaseViewModel {
  CalculatorViewModel({
    required this.overtimeApi,
  });
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController overtimeController = TextEditingController();

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    salaryController.dispose();
    overtimeController.dispose();
    super.disposeModel();
  }

  final OvertimeApi overtimeApi;
  CalculateOvertimeResponse? calculate;

  DayType? selectedDayType;
  WorkingDays? selectedWorkingDays;

  final List<DayType> dayTypes = [
    DayType(id: 'regular', title: 'Hari Biasa'),
    DayType(id: 'holiday', title: 'Hari Libur'),
  ];

  final List<WorkingDays> workingDays = [
    WorkingDays(id: '5', title: '5 Hari Kerja'),
    WorkingDays(id: '6', title: '6 Hari Kerja'),
  ];

  // Dropdown hanya akan muncul jika user memilih "Hari Libur" sebagai jenis hari lembur.
  bool get showWorkingDaysDropdown => selectedDayType?.id == 'holiday';

  // Mengecek apakah semua field telah terisi dengan valid. Tombol submit akan diaktifkan hanya jika semua field sudah diisi.
  bool get isFormValid => salaryController.text.isNotEmpty && overtimeController.text.isNotEmpty && selectedDayType != null && (!showWorkingDaysDropdown || selectedWorkingDays != null);

  // Format angka dengan titik (contoh: 5.000.000)
  String formatCurrency(double value) {
    final formatCurrency = NumberFormat("#,##0", "id_ID");
    return formatCurrency.format(value);
  }

  // Format angka dengan titik dan rupiah (contoh: Rp. 5.000.000)
  String formatCurrencyRupiah(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), ''); // Hanya angka
    if (cleanedValue.isEmpty) return '';

    final numberFormat = NumberFormat("#,###", "id_ID");
    return "Rp. ${numberFormat.format(int.parse(cleanedValue))}";
  }

  // Update text field salary agar otomatis memformat tampilan
  void onSalaryChanged(String value) {
    String formatted = formatCurrencyRupiah(value);
    salaryController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    notifyListeners();
  }

  void updateDayType(DayType newDayType) {
    selectedDayType = newDayType;
    notifyListeners();
  }

  void updateWorkingDays(WorkingDays newWorkingDays) {
    selectedWorkingDays = newWorkingDays;
    notifyListeners();
  }

  void resetCalculate() {
    salaryController.clear();
    overtimeController.clear();
    selectedDayType = null;
    selectedWorkingDays = null;
    calculate = null;
    notifyListeners();
  }

  Future<void> calculateOvertime() async {
    setBusy(true);
    try {
      final double salary = double.parse(salaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));
      final double hours = double.parse(overtimeController.text);
      final String dayType = selectedDayType!.id;
      final int workingDays = showWorkingDaysDropdown && selectedWorkingDays != null ? int.parse(selectedWorkingDays!.id) : 5;
      final CalculateOvertimeRequest calculateOvertimeRequest = CalculateOvertimeRequest(
        monthlySalary: salary,
        dayType: dayType,
        workingDays: workingDays,
        overtimeHours: hours,
      );
      final HttpResponse<CalculateOvertimeResponse> calculateOvertimeResponse = await overtimeApi.getCalculateOvertime(
        request: calculateOvertimeRequest,
      );
      log('Get Calculate Response: ${calculateOvertimeResponse.response.statusCode} - ${calculateOvertimeResponse.data.overtimeDetails}');
      if (calculateOvertimeResponse.response.statusCode == 200) {
        calculate = calculateOvertimeResponse.data;
        notifyListeners();
      } else {
        final result = calculateOvertimeResponse.data;
        log(result.message);
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
