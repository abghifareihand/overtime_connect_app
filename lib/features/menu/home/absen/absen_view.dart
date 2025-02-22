import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/components/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/home/absen/absen_view_model.dart';
import 'package:overtime_connect_app/features/menu/home/absen/widgets/calculate_card.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/ui/components/custom_date_picker.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/components/custom_hours_overtime.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_tabbar.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

class AbsenView extends StatelessWidget {
  final double salary;
  final int workingDays;
  const AbsenView({
    super.key,
    required this.salary,
    required this.workingDays,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<AbsenViewModel>(
      model: AbsenViewModel(
        overtimeApi: Provider.of(context),
        salary: salary,
        workingDays: workingDays,
      ),
      onModelReady: (AbsenViewModel model) => model.initModel(),
      onModelDispose: (AbsenViewModel model) => model.disposeModel(),
      builder: (BuildContext context, AbsenViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model, salary, workingDays),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, AbsenViewModel model, double salary, int workingDays) {
  return CustomScaffold(
    title: 'Absensi',
    subtitle: 'Catat lemburmu dengan teratur',
    child: Column(
      children: [
        CustomTabbar(
          selectedIndex: model.selectedIndex,
          onTabSelected: (index) {
            model.onTabSelected(index);
          },
          leftLabel: 'Masuk',
          rightLabel: 'Tidak Masuk',
        ),
        Expanded(
          child: model.selectedIndex == 0 ? _buildTabMasuk(context, model, salary, workingDays) : _buildTabTidakMasuk(context, model),
        ),
      ],
    ),
  );
}

Widget _buildTabMasuk(BuildContext context, AbsenViewModel model, double salary, int workingDays) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDatePicker(
          controller: model.dateAbsentController,
          label: 'Tanggal Lembur',
          onDateSelected: model.updateDateAbsent,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomDropdown(
          label: 'Keterangan',
          hintText: 'Pilih keterangan lembur',
          value: model.selectedDayType?.id, // Simpan & gunakan ID
          items: model.dayTypes.map((e) => e.id).toList(), // ID untuk dropdown
          itemLabels: model.dayTypes.map((e) => e.title).toList(), // Title yang ditampilkan di UI
          onChanged: (String? newValue) {
            if (newValue != null) {
              final selected = model.dayTypes.firstWhere((e) => e.id == newValue);
              model.updateDayType(selected); // Simpan ID yang dipilih
            }
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomHoursOvertime(
          controller: model.hoursController,
          label: 'Jam Lembur',
          onChanged: model.updateHours,
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text(
          'Hasil Perhitungan',
          style: AppFont.semiBold.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        CalculateCard(
          date: model.dateAbsentController.text,
          absen: 'Masuk',
          hours: double.tryParse(model.hoursController.text),
          total: (double.tryParse(model.hoursController.text) ?? 0).calculateOvertime(
            salary,
            model.selectedDayType?.id ?? '',
            workingDays,
          ),
          onPressed: model.isFormValidAbsent
              ? () {
                  showLoadingDialog(context);
                  model.addOvertimeAbsent(
                    success: (message) {
                      hideLoadingDialog(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MenuView()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    error: (message) {
                      hideLoadingDialog(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  );
                }
              : null,
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    ),
  );
}

Widget _buildTabTidakMasuk(
  BuildContext context,
  AbsenViewModel model,
) {
  return SingleChildScrollView(
    child: Column(
      children: [
        CalculateCard(
          date: DateTime.now().toFormattedDate(),
          absen: 'Tidak Masuk',
          hours: 0,
          total: 0,
          onPressed: () {
            showLoadingDialog(context);
            model.addOvertimeNotPresent(
              success: (message) {
                hideLoadingDialog(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MenuView()),
                  (Route<dynamic> route) => false,
                );
              },
              error: (message) {
                hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  );
}
