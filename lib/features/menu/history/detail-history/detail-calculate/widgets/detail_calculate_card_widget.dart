import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/models/get_calculate_model.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

class DetailCalculateCardWidget extends StatelessWidget {
  final GetCalculateDetailResponse calculateDetail;
  const DetailCalculateCardWidget({
    super.key,
    required this.calculateDetail,
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                calculateDetail.data.date.toFormattedDateIndo(),
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
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: calculateDetail.data.overtimeDetails.length,
            separatorBuilder: (context, index) => _calculateDivider(),
            itemBuilder: (context, index) {
              final overtime = calculateDetail.data.overtimeDetails[index];
              return Column(
                children: [
                  Text(
                    'Lembur Jam ke-$index',
                    style: AppFont.semiBold.copyWith(
                      color: AppColor.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    overtime.formula,
                    style: AppFont.medium.copyWith(
                      color: AppColor.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),

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
                calculateDetail.data.totalOvertime.toCurrency(),
                style: AppFont.bold.copyWith(
                  color: AppColor.primary,
                  fontSize: 16,
                ),
              ),
            ],
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
      bottom: 4,
    ),
    child: Divider(
      color: AppColor.secondary,
    ),
  );
}
