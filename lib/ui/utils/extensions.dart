import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String toFormattedDate() {
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
  }

  // Untuk mengirimkan ke API dalam format yyyy-MM-dd
  String toApiFormattedDate() {
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String format24Hour() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

extension CurrencyFormatter on num {
  String toCurrency() {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return formatCurrency.format(this);
  }

  String toCurrencyWithoutRp() {
    final formatCurrency = NumberFormat('#,##0', 'id_ID');
    return formatCurrency.format(this);
  }
}

extension CurrencyParser on String {
  double toDoubleFromCurrency() {
    // Hapus simbol 'Rp. ' dan semua karakter selain angka
    String cleaned = replaceAll(RegExp(r'[^0-9]'), '');

    // Konversi ke double
    return double.tryParse(cleaned) ?? 0;
  }
}

extension MonthFormatter on String {
  String toMonthYear(String year) {
    if (isEmpty || year.isEmpty) return '-';
    DateTime date = DateTime(int.parse(year), int.parse(this), 1);
    return DateFormat('MMMM').format(date);
  }
}

extension MonthFormatterLocal on String {
  String toMonthNameIndo() {
    final months = {
      '01': 'Januari',
      '02': 'Februari',
      '03': 'Maret',
      '04': 'April',
      '05': 'Mei',
      '06': 'Juni',
      '07': 'Juli',
      '08': 'Agustus',
      '09': 'September',
      '10': 'Oktober',
      '11': 'November',
      '12': 'Desember',
    };

    return months[this] ?? '-';
  }
}

extension MonthYearFormatterLocal on DateTime {
  String toMonthYearIndo() {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${months[month - 1]} $year';
  }
}

extension DateFormatterIndo on String {
  String toFormattedDateIndo() {
    DateTime date = DateTime.parse(this);

    List<String> weekDays = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    List<String> months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

    String dayName = weekDays[date.weekday - 1]; // Fix index weekday
    String monthName = months[date.month - 1]; // Fix index month

    return '$dayName, ${date.day} $monthName ${date.year}';
  }
}

extension OvertimeCalculation on double {
  double calculateOvertime(double monthlySalary, String dayType, int workingDays) {
    // Menghitung upah per jam berdasarkan gaji bulanan
    double hourlyWage = monthlySalary / 173;
    double totalOvertime = 0.0;
    double firstHourWage = hourlyWage * 1.5;
    double subsequentHourWage = hourlyWage * 2;

    // Jika tipe hari adalah Libur atau Akhir Pekan
    if (dayType == 'holiday') {
      if (workingDays == 5) {
        // Untuk perusahaan dengan 5 hari kerja per minggu
        if (this <= 8) {
          totalOvertime = this * (hourlyWage * 2); // 2x upah per jam untuk 8 jam pertama
        } else if (this == 9) {
          totalOvertime = 8 * (hourlyWage * 2) + (hourlyWage * 3); // 3x upah per jam untuk jam ke-9
        } else if (this > 9) {
          totalOvertime = 8 * (hourlyWage * 2) + (hourlyWage * 3) + ((this - 9) * (hourlyWage * 4)); // 4x upah per jam untuk jam ke-10 dan seterusnya
        }
      } else if (workingDays == 6) {
        // Untuk perusahaan dengan 6 hari kerja per minggu
        if (this <= 7) {
          totalOvertime = this * (hourlyWage * 2); // 2x upah per jam untuk 7 jam pertama
        } else if (this == 8) {
          totalOvertime = 7 * (hourlyWage * 2) + (hourlyWage * 3); // 3x upah per jam untuk jam ke-8
        } else if (this > 8) {
          totalOvertime = 7 * (hourlyWage * 2) + (hourlyWage * 3) + ((this - 8) * (hourlyWage * 4)); // 4x upah per jam untuk jam ke-9 dan seterusnya
        }
      }
    } else if (dayType == 'regular') {
      // Hari kerja biasa (Senin - Jumat)
      // Jika jam lembur hanya 1 jam, maka hanya dihitung 1,5x upah per jam (firstHourWage)
      if (this == 1) {
        totalOvertime = firstHourWage;
        // Jika jam lembur lebih dari 1 jam, maka jam pertama dihitung dengan tarif 1,5x,
        // dan sisanya dihitung dengan tarif 2x per jam (subsequentHourWage).
      } else if (this > 1) {
        totalOvertime = firstHourWage + (this - 1) * subsequentHourWage;
      }
    } else {
      totalOvertime = 0.0;
    }

    return totalOvertime;
  }
}
