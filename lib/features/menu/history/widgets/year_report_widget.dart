import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class YearReportWidget extends StatelessWidget {
  final String month;
  final VoidCallback onPressed;
  const YearReportWidget({
    super.key,
    required this.month,
    required this.onPressed,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PaySlip',
            style: AppFont.regular.copyWith(
              color: AppColor.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Assets.svg.icCalender.svg(),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                month,
                style: AppFont.bold.copyWith(
                  color: AppColor.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          _divider(),
          Button.filled(
            borderRadius: 10,
            height: 46,
            onPressed: onPressed,
            label: 'Lihat',
          ),
        ],
      ),
    );
  }
}

Widget _divider() {
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
