import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/history/detail-history/detail_history_view.dart';
import 'package:overtime_connect_app/features/menu/history/history_view_model.dart';
import 'package:overtime_connect_app/features/menu/history/widgets/select_year_dropdown.dart';
import 'package:overtime_connect_app/features/menu/history/widgets/year_report_widget.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HistoryViewModel>(
      model: HistoryViewModel(
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
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.primary,
      ),
    );
  }
  return CustomScaffold(
    title: 'History',
    showBackButton: false,
    child: Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        SelectYearDropdown(
          value: model.selectedYears ?? (model.overtimeYears?.years.isNotEmpty == true ? model.overtimeYears!.years.last : null),
          items: model.overtimeYears?.years.toList() ?? [],
          onChanged: (String? newValue) {
            if (newValue != null) {
              model.updateSelectedYear(newValue);
              model.getReportYearly();
            }
          },
        ),

        // get data report yearly after selectYearDropdown
        Expanded(
          child: ListView.separated(
            itemCount: model.reportYearlyResponse?.data.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(
              height: 16.0,
            ),
            itemBuilder: (context, index) {
              final year = model.reportYearlyResponse!.year;
              final keys = model.reportYearlyResponse!.data.keys.toList(); // Ambil key bulan
              final monthKey = keys[index];
              final monthIndo = keys[index].toMonthNameIndo();
              return YearReportWidget(
                month: '$monthIndo $year',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailHistoryView(
                        detailMonth: monthKey,
                        detailYear: year,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
