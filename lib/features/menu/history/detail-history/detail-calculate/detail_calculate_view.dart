import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/history/detail-history/detail-calculate/detail_calculate_view_model.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';
import 'package:provider/provider.dart';

class DetailCalculateView extends StatelessWidget {
  final int calculateId;
  const DetailCalculateView({
    super.key,
    required this.calculateId,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailCalculateViewModel>(
      model: DetailCalculateViewModel(
        overtimeApi: Provider.of(context),
        calculateId: calculateId,
      ),
      onModelReady: (DetailCalculateViewModel model) => model.initModel(),
      onModelDispose: (DetailCalculateViewModel model) => model.disposeModel(),
      builder: (BuildContext context, DetailCalculateViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, DetailCalculateViewModel model) {
  return CustomScaffold(
    title: 'Detail Calculate',
    subtitle: '',
    child: model.isBusy
        ? Center(
            child: CircularProgressIndicator(
              color: AppColor.primary,
            ),
          )
        : ListView(
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    model.reportDetail!.date.toFormattedDateIndo(),
                    style: AppFont.medium.copyWith(
                      color: AppColor.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.reportDetail!.data.length,
                separatorBuilder: (context, index) => _calculateDivider(),
                itemBuilder: (context, index) {
                  final overtime = model.reportDetail!.data[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lembur Jam ke-${index + 1} :',
                        style: AppFont.semiBold.copyWith(
                          color: AppColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            overtime.formula,
                            style: AppFont.medium.copyWith(
                              color: AppColor.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            overtime.result.toCurrency(),
                            style: AppFont.semiBold.copyWith(
                              color: AppColor.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: AppFont.bold.copyWith(
                      color: AppColor.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    model.reportDetail!.totalOvertime.toCurrency(),
                    style: AppFont.bold.copyWith(
                      color: AppColor.primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          ),
  );
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
