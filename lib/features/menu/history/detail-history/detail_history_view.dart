import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/history/detail-history/detail_history_view_model.dart';
import 'package:overtime_connect_app/features/menu/history/detail-history/widgets/overtime_card_widget.dart';
import 'package:overtime_connect_app/features/menu/history/detail-history/widgets/salary_card_widget.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/components/custom_tabbar.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';
import 'package:provider/provider.dart';

class DetailHistoryView extends StatelessWidget {
  final String detailMonth;
  final String detailYear;
  const DetailHistoryView({
    super.key,
    required this.detailMonth,
    required this.detailYear,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailHistoryViewModel>(
      model: DetailHistoryViewModel(
        authApi: Provider.of(context),
        overtimeApi: Provider.of(context),
        detailMonth: detailMonth,
        detailYear: detailYear,
      ),
      onModelReady: (DetailHistoryViewModel model) => model.initModel(),
      onModelDispose: (DetailHistoryViewModel model) => model.disposeModel(),
      builder: (BuildContext context, DetailHistoryViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, DetailHistoryViewModel model) {
  return CustomScaffold(
    title: 'Detail History',
    subtitle: '',
    child: Column(
      children: [
        CustomTabbar(
          selectedIndex: model.selectedIndex,
          onTabSelected: (index) {
            model.onTabSelected(index);
          },
          leftLabel: 'Detail Gaji',
          rightLabel: 'Detail Lembur',
        ),
        Expanded(
          child: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primary,
                  ),
                )
              : (model.selectedIndex == 0 ? _buildTabSalary(context, model) : _buildTabOvertime(context, model)),
        ),
      ],
    ),
  );
}

Widget _buildTabSalary(
  BuildContext context,
  DetailHistoryViewModel model,
) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keterangan Gaji ${model.month!.toMonthNameIndo()} ${model.year}',
          style: AppFont.medium.copyWith(
            color: AppColor.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SalaryCardWidget(
          salary: model.salary!,
          overtime: model.overtime!,
          total: model.totalSalary,
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    ),
  );
}

Widget _buildTabOvertime(
  BuildContext context,
  DetailHistoryViewModel model,
) {
  final isOvertimeEmpty = model.report == null || model.report!.data.isEmpty;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isOvertimeEmpty)
          Text(
            'Keterangan Lembur ${model.month!.toMonthNameIndo()} ${model.year}',
            style: AppFont.medium.copyWith(
              color: AppColor.black,
              fontSize: 16,
            ),
          ),
        const SizedBox(height: 10.0),
        isOvertimeEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        'Belum ada data lembur',
                        style: AppFont.medium.copyWith(
                          color: AppColor.gray,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.report!.data.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                itemBuilder: (context, index) {
                  final report = model.report!.data[index];
                  return OvertimeCardWidget(report: report);
                },
              ),
        const SizedBox(height: 20.0),
      ],
    ),
  );
}
