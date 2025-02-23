import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/core/models/report_model.dart';
import 'package:overtime_connect_app/features/menu/history/detail-history/detail-calculate/detail_calculate_view.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

class OvertimeCardWidget extends StatelessWidget {
  final ReportData report;
  const OvertimeCardWidget({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: report.status == 1
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailCalculateView(calculateId: report.id),
                ),
              );
            }
          : null,
      child: Container(
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  report.date.toFormattedDateIndo(),
                  // 'tested tanggal',
                  style: AppFont.medium.copyWith(
                    color: AppColor.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            _calculateTile(
              icon: Assets.svg.icFinger.svg(),
              title: 'Absensi',
              value: report.status == 1 ? (report.dayType == 'regular' ? 'Masuk Hari Biasa' : (report.dayType == 'holiday' ? 'Masuk Hari Libur' : 'Tidak Masuk')) : 'Tidak Masuk',
            ),
            _calculateDivider(),
            _calculateTile(
              icon: Assets.svg.icTime.svg(),
              title: 'Jumlah Lembur',
              value: '${report.overtimeHours} Jam',
            ),
            _calculateDivider(),

            // Total Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppFont.regular.copyWith(
                    color: AppColor.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  report.totalOvertime.toCurrency(),
                  style: AppFont.bold.copyWith(
                    color: AppColor.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
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
            style: AppFont.regular.copyWith(
              color: AppColor.black,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: AppFont.semiBold.copyWith(
              color: AppColor.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ],
  );
}
