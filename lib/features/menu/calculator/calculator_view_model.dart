import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overtime_connect_app/core/models/day_type_model.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

class CalculatorViewModel extends BaseViewModel {
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

  double? overtimeResult;
  bool isCalculated = false;
  List<String> overtimeFormulas = [];
  List<double> overtimeResults = [];

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

  // Fungsi untuk reset semua input dan hasil
  void reset() {
    salaryController.clear();
    overtimeController.clear();
    selectedDayType = null;
    selectedWorkingDays = null;
    overtimeResult = null; // Hapus hasil perhitungan
    isCalculated = false; // Set kembali ke kondisi awal
    overtimeFormulas.clear(); // Hapus semua rumus
    overtimeResults.clear(); // Hapus semua hasil
    notifyListeners();
  }

  void updateDayType(DayType newDayType) {
    selectedDayType = newDayType;
    resetCalculation();
    notifyListeners();
  }

  void updateWorkingDays(WorkingDays newWorkingDays) {
    selectedWorkingDays = newWorkingDays;
    resetCalculation();
    notifyListeners();
  }

  void resetCalculation() {
    isCalculated = false;
    overtimeResult = null;
    overtimeFormulas.clear();
    overtimeResults.clear();
    notifyListeners();
  }

  void calculateOvertimes() {
    final double salary = double.parse(salaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final double hours = double.parse(overtimeController.text);

    // Validasi agar selectedDayType tidak null
    if (selectedDayType == null) return;

    final String dayType = selectedDayType!.id;
    final int workingDays = showWorkingDaysDropdown && selectedWorkingDays != null ? int.parse(selectedWorkingDays!.id) : 5; // Default 5 hari kerja jika tidak dipilih

    if (salary > 0 && hours > 0) {
      overtimeFormulas.clear();
      overtimeResults.clear();

      // Gunakan ekstensi untuk perhitungan overtime
      final double totalOvertime = hours.calculateOvertime(salary, dayType, workingDays);

      for (int i = 1; i <= hours; i++) {
        String formula;
        double currentOvertime = (i.toDouble()).calculateOvertime(salary, dayType, workingDays) - (i > 1 ? (i - 1).toDouble().calculateOvertime(salary, dayType, workingDays) : 0);

        String formattedSalary = formatCurrency(salary);
        formula = '$formattedSalary x ${(currentOvertime / (salary / 173)).toStringAsFixed(1)} / 173';

        overtimeFormulas.add(formula);
        overtimeResults.add(currentOvertime);
      }

      overtimeResult = totalOvertime;
      isCalculated = true;
    } else {
      isCalculated = false;
    }

    notifyListeners();
  }
}
