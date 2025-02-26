import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('id');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hapus semua karakter selain angka
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Jika kosong, return langsung agar tidak error
    if (numericString.isEmpty) return newValue.copyWith(text: '');

    // Format angka dengan titik pemisah ribuan
    String formattedText = _formatter.format(int.parse(numericString));

    // Mengatur posisi kursor ke akhir teks
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class RupiahInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('id');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hapus semua karakter kecuali angka
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Jika kosong, tampilkan hanya "Rp. "
    if (numericString.isEmpty) {
      return newValue.copyWith(text: 'Rp. ');
    }

    // Format angka dengan titik sebagai pemisah ribuan
    String formattedText = 'Rp. ${_formatter.format(int.parse(numericString))}';

    // Mengatur posisi kursor agar tetap di akhir teks
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class DoubleInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Hapus karakter selain angka dan titik
    newText = newText.replaceAll(RegExp(r'[^0-9.]'), '');

    // Pastikan hanya ada satu titik dalam input
    if (newText.contains('.') && newText.indexOf('.') != newText.lastIndexOf('.')) {
      newText = oldValue.text; // Kembalikan ke nilai sebelumnya jika ada lebih dari satu titik
    }

    // Pisahkan angka sebelum dan setelah titik
    List<String> parts = newText.split('.');

    // Batasi angka sebelum titik maksimal 2 digit
    if (parts[0].length > 2) {
      parts[0] = parts[0].substring(0, 2);
    }

    // Jika ada angka setelah titik, pastikan hanya bisa 5
    if (parts.length > 1) {
      String afterDecimal = parts[1];
      if (afterDecimal != '5') {
        parts[1] = ''; // Hapus jika bukan angka 5
      }
    }

    // Gabungkan kembali angka sebelum dan setelah titik
    newText = parts.join('.');

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
