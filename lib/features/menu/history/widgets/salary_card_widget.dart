import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

class SalaryCardWidget extends StatelessWidget {
  final double salary;
  final double overtimeHours;
  final double overtimeTotal;
  final double total;
  const SalaryCardWidget({
    super.key,
    required this.salary,
    required this.overtimeHours,
    required this.overtimeTotal,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
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
        children: [
          _salaryTile(
            title: 'Gaji Pokok',
            value: salary,
          ),
          _salaryDivider(),
          _hoursTile(
            title: 'Jam Lembur',
            value: overtimeHours,
          ),
          _salaryDivider(),
          _salaryTile(
            title: 'Jumlah Lemburan',
            value: overtimeTotal,
          ),
          _salaryDivider(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppFont.medium.copyWith(
                    color: AppColor.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  total.toCurrency(),
                  style: AppFont.semiBold.copyWith(
                    color: AppColor.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _salaryDivider() {
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

Widget _salaryTile({
  required String title,
  required double value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppFont.regular.copyWith(
          color: AppColor.black,
          fontSize: 12,
        ),
      ),
      const SizedBox(height: 4.0),
      Text(
        value.toCurrency(),
        style: AppFont.bold.copyWith(
          color: AppColor.black,
          fontSize: 12,
        ),
      ),
    ],
  );
}

Widget _hoursTile({
  required String title,
  required double value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppFont.regular.copyWith(
          color: AppColor.black,
          fontSize: 12,
        ),
      ),
      const SizedBox(height: 4.0),
      Text(
        value % 1 == 0
            ? '${value.toInt()} Jam' // Menampilkan angka bulat tanpa desimal
            : '$value Jam', // Menampilkan angka dengan 1 desimal jika tidak bulat,
        style: AppFont.bold.copyWith(
          color: AppColor.black,
          fontSize: 12,
        ),
      ),
    ],
  );
}
