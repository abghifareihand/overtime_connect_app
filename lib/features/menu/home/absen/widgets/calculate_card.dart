import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

class CalculateCard extends StatelessWidget {
  final String absen;
  final String date;
  final double hours;
  final Function()? onPressed;
  final double? totalOvertime;
  const CalculateCard({
    super.key,
    required this.absen,
    required this.date,
    required this.hours,
    required this.onPressed,
    this.totalOvertime,
  });

  @override
  Widget build(BuildContext context) {
    // Pastikan jika hours kosong atau 0, total menjadi 0
    final displayTotal = (hours > 0) ? (totalOvertime != null ? totalOvertime!.toCurrency() : 0.toCurrency()) : 0.toCurrency(); // Jika hours 0 atau kosong, tampilkan 0
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.white,
        border: Border.all(color: AppColor.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _calculateTile(
            icon: Assets.svg.icCalender.svg(),
            title: 'Tanggal',
            value: date.isNotEmpty ? date : 'Belum pilih tanggal',
          ),
          _calculateDivider(),
          _calculateTile(
            icon: Assets.svg.icFinger.svg(),
            title: 'Absensi',
            value: absen,
          ),
          _calculateDivider(),
          _calculateTile(
            icon: Assets.svg.icTime.svg(),
            title: 'Jumlah Lembur',
            value: hours > 0
                ? (hours % 1 == 0
                    ? '${hours.toInt()} Jam' // Menampilkan angka bulat tanpa desimal
                    : '$hours Jam') // Menampilkan angka dengan desimal jika tidak bulat
                : '0 Jam', // Jika jam 0, tampilkan '0 Jam'
          ),

          _calculateDivider(),

          // Total Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppFont.regular.copyWith(color: AppColor.black, fontSize: 14),
              ),
              Text(
                displayTotal, // Tampilkan "-" jika belum ada perhitungan
                style: AppFont.bold.copyWith(color: AppColor.primary, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Save Button
          Button.filled(
            height: 48,
            onPressed: onPressed,
            label: 'Simpan',
          ),
        ],
      ),
    );
  }
}

Widget _calculateDivider() {
  return Padding(
    padding: const EdgeInsets.only(
      top: 4,
      bottom: 8,
    ),
    child: Divider(
      color: AppColor.secondary,
    ),
  );
}

Widget _calculateTile({
  required Widget icon,
  required String title,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      icon,
      const SizedBox(width: 8.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFont.regular.copyWith(color: AppColor.black, fontSize: 12),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: AppFont.semiBold.copyWith(color: AppColor.black, fontSize: 12),
          ),
        ],
      ),
    ],
  );
}
