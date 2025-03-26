import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/history/widgets/overtime_card_widget.dart';
import 'package:overtime_connect_app/features/menu/history/widgets/salary_card_widget.dart';
import 'package:overtime_connect_app/features/menu/history/history_view_model.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/ui/components/custom_alert_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_date_range_picker.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/components/custom_tabbar.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HistoryViewModel>(
      model: HistoryViewModel(
        authApi: Provider.of(context),
        overtimeApi: Provider.of(context),
      ),
      onModelReady: (HistoryViewModel model) => model.initModel(),
      onModelDispose: (HistoryViewModel model) => model.disposeModel(),
      builder: (BuildContext context, HistoryViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, HistoryViewModel model) {
  return CustomScaffold(
    showBackButton: false,
    title: 'History',
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
              : (model.selectedIndex == 0
                  ? _buildTabSalary(context, model)
                  : _buildTabOvertime(context, model)),
        ),
      ],
    ),
  );
}

Widget _buildTabSalary(
  BuildContext context,
  HistoryViewModel model,
) {
  final isOvertimeEmpty = model.reportDate == null || model.reportDate!.data.isEmpty;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              builder: (context) => Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDateRangePicker(
                      initialStart: model.selectedStartDate,
                      initialEnd: model.selectedEndDate,
                      onConfirmPressed: (start, end) {
                        model.setDateRange(start, end);
                        model.getReportDate();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.primary,
              ),
            ),
            child: Row(
              children: [
                Assets.svg.icCalender.svg(
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primary,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  model.dateRange ?? '',
                  style: AppFont.semiBold.copyWith(
                    color: AppColor.primary,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Spacer(),
                Icon(
                  Icons.expand_more,
                  color: AppColor.primary,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isOvertimeEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'Belum ada data lembur',
                    style: AppFont.medium.copyWith(
                      color: AppColor.gray,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : SalaryCardWidget(
                salary: model.salary!,
                overtimeHours: model.overtimeHours!,
                overtimeTotal: model.overtimeAmount!,
                total: model.totalSalary,
              ),
      ],
    ),
  );
}

Widget _buildTabOvertime(
  BuildContext context,
  HistoryViewModel model,
) {
  final isOvertimeEmpty = model.reportDate == null || model.reportDate!.data.isEmpty;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              builder: (context) => Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDateRangePicker(
                      initialStart: model.selectedStartDate ?? DateTime.now(),
                      initialEnd: model.selectedEndDate ?? DateTime.now(),
                      onConfirmPressed: (start, end) {
                        model.setDateRange(start, end);
                        model.getReportDate();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.primary,
              ),
            ),
            child: Row(
              children: [
                Assets.svg.icCalender.svg(
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primary,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  model.dateRange ?? '',
                  style: AppFont.semiBold.copyWith(
                    color: AppColor.primary,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Spacer(),
                Icon(
                  Icons.expand_more,
                  color: AppColor.primary,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isOvertimeEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'Belum ada data lembur',
                    style: AppFont.medium.copyWith(
                      color: AppColor.gray,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.reportDate!.data.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                itemBuilder: (context, index) {
                  final report = model.reportDate!.data[index];
                  return OvertimeCardWidget(
                    report: report,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                            title: 'Apakah anda yakin ingin menghapus data lembur ini?',
                            onPressed: () {
                              model.deleteReportDate(
                                report.id,
                                success: (message) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuView(),
                                    ),
                                  );
                                },
                                error: (message) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
        const SizedBox(height: 20.0),
      ],
    ),
  );
}
