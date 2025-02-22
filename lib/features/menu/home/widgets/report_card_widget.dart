import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class ReportCardWidget extends StatelessWidget {
  final String monthTitle;
  final String overtime;
  final String month;
  final String total;
  const ReportCardWidget({
    super.key,
    required this.monthTitle,
    required this.overtime,
    required this.month,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFA9CDFF),
            Color(0xFF7AA7FA),
            Color(0xFF4483F8),
            Color(0xFF2871F6),
            Color(0xFF0D5EF5),
          ],
          stops: [0.0, 0.34, 0.75, 0.88, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$monthTitle Report',
            style: AppFont.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            'Overtime',
            style: AppFont.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF003FB7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildItem(
                  title: 'Lembur',
                  subtitle: overtime,
                ),
                _buildDivider(),
                _buildItem(
                  title: 'Bulan',
                  subtitle: month,
                ),
                _buildDivider(),
                _buildItem(
                  title: 'Total',
                  subtitle: total,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColor.white,
    );
  }

  Widget _buildItem({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppFont.medium.copyWith(
            color: AppColor.secondary,
            fontSize: 12,
          ),
        ),
        Text(
          subtitle,
          style: AppFont.bold.copyWith(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
