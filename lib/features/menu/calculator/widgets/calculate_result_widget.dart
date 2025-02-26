import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/models/calculate_overtime_model.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

class CalculateResultWidget extends StatelessWidget {
  final CalculateOvertimeResponse calculateOvertime;
  final VoidCallback onReset;
  const CalculateResultWidget({
    super.key,
    required this.calculateOvertime,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hasil Perhitungan',
          style: AppFont.semiBold.copyWith(
            color: AppColor.black,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
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
              Column(
                children: [
                  for (int i = 0; i < calculateOvertime.overtimeDetails.length; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jam ke-${i + 1}',
                              style: AppFont.medium.copyWith(
                                color: AppColor.black,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              calculateOvertime.overtimeDetails[i].formula,
                              style: AppFont.medium.copyWith(
                                color: AppColor.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          calculateOvertime.overtimeDetails[i].result.toCurrencyWithoutRp(),
                          style: AppFont.bold.copyWith(
                            color: AppColor.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 12,
                      ),
                      child: Divider(
                        height: 1,
                        color: AppColor.secondary,
                      ),
                    ),
                  ],
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: AppFont.semiBold.copyWith(
                        color: AppColor.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      calculateOvertime.totalOvertime.toCurrencyWithoutRp(),
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
        ),
        const SizedBox(
          height: 16.0,
        ),
        Button.filled(
          height: 48,
          onPressed: onReset,
          label: 'Reset',
          color: AppColor.red,
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
