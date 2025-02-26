import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/home/absen/absen_view.dart';
import 'package:overtime_connect_app/features/menu/home/home_view_model.dart';
import 'package:overtime_connect_app/features/menu/home/widgets/report_calendar_widget.dart';
import 'package:overtime_connect_app/features/menu/home/widgets/report_card_widget.dart';
import 'package:overtime_connect_app/features/menu/home/widgets/report_chart_widget.dart';
import 'package:overtime_connect_app/features/menu/home/widgets/report_dropdown.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      model: HomeViewModel(
        authApi: Provider.of(context),
        overtimeApi: Provider.of(context),
      ),
      onModelReady: (HomeViewModel model) => model.initModel(),
      onModelDispose: (HomeViewModel model) => model.disposeModel(),
      builder: (BuildContext context, HomeViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
          floatingActionButton: _buildFloating(context, model),
        );
      },
    );
  }
}

Widget _buildFloating(BuildContext context, HomeViewModel model) {
  return FloatingActionButton(
    elevation: 2,
    shape: CircleBorder(),
    backgroundColor: AppColor.secondary,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AbsenView(
            salary: model.user!.salary,
            workingDays: model.user!.workingDays,
          ),
        ),
      );
    },
    child: Icon(
      Icons.add_rounded,
      color: AppColor.primary,
      size: 48,
    ),
  );
}

Widget _buildBody(BuildContext context, HomeViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.primary,
      ),
    );
  }
  return SingleChildScrollView(
    child: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Header
            Container(
              height: 168,
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 48,
                  left: 28,
                  right: 28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Datang,',
                          style: AppFont.regular.copyWith(
                            color: AppColor.primary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          model.user?.fullname ?? '',
                          style: AppFont.bold.copyWith(
                            color: AppColor.primary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      color: AppColor.primary,
                      Icons.notifications,
                    ),
                  ],
                ),
              ),
            ),

            // Card report
            Positioned(
              top: 120,
              left: 24,
              right: 24,
              child: ReportCardWidget(
                monthTitle: model.monthOvertime!.toMonthNameIndo(),
                overtime: '${model.hoursOvertime} Jam',
                month: model.monthOvertime!.toMonthNameIndo(),
                total: model.totalOvertime!.toCurrency(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 120.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overview',
                style: AppFont.semiBold.copyWith(
                  color: AppColor.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              ReportDropdown(
                value: model.selectedReport,
                items: [
                  'Mingguan',
                  'Bulanan',
                ],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    model.updateSelectedReport(newValue); // Call to switch view and fetch the respective data
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              model.selectedReport == 'Mingguan'
                  ? (model.isLoading // Cek apakah sedang loading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primary, // Sesuaikan dengan tema aplikasi
                            ),
                          ),
                        )
                      : (model.overtimeData.isNotEmpty
                          ? ReportChartWidget(
                              data: model.weeklyChartData,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Center(
                                child: Text(
                                  "Belum ada data lembur untuk minggu ini",
                                  style: AppFont.semiBold.copyWith(
                                    color: AppColor.gray,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )))
                  : (model.isLoading // Tambahkan loading untuk Monthly juga
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primary,
                            ),
                          ),
                        )
                      : (model.overtimeData.isNotEmpty
                          ? ReportCalendarWidget(
                              isToday: model.isToday,
                              hasOvertime: model.hasOvertime,
                              disableOvertime: model.isOvertimeDisabled,
                              overtimeText: model.getOvertimeText,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Center(
                                child: Text(
                                  "Belum ada data lembur untuk bulan ini",
                                  style: AppFont.semiBold.copyWith(
                                    color: AppColor.gray,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ))),
            ],
          ),
        ),
        const SizedBox(
          height: 80.0,
        ),
      ],
    ),
  );
}
