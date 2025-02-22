import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/calculator/calculator_view_model.dart';
import 'package:overtime_connect_app/features/menu/calculator/widgets/calculate_result_widget.dart';
import 'package:overtime_connect_app/features/menu/calculator/widgets/salary_input_field.dart';
import 'package:overtime_connect_app/features/menu/calculator/widgets/work_input_field.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_dropdown.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CalculatorViewModel>(
      model: CalculatorViewModel(),
      onModelReady: (CalculatorViewModel model) => model.initModel(),
      onModelDispose: (CalculatorViewModel model) => model.disposeModel(),
      builder: (BuildContext context, CalculatorViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, CalculatorViewModel model) {
  return CustomScaffold(
    title: 'Calculator',
    showBackButton: false,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 28.0,
          ),
          SalaryInputField(
            label: 'Gaji Pokok',
            hintText: 'Masukkan gaji pokok',
            controller: model.salaryController,
            onChanged: model.onSalaryChanged,
          ),
          const SizedBox(
            height: 16.0,
          ),
          WorkInputField(
            label: 'Jumlah Jam Lembur',
            hintText: 'Masukkan jumlah lembur',
            suffixText: 'Jam',
            controller: model.overtimeController,
          ),
          const SizedBox(
            height: 16.0,
          ),
          CustomDropdown(
            label: 'Jenis Hari Lembur',
            hintText: 'Pilih hari lembur',
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
          if (model.showWorkingDaysDropdown)
            CustomDropdown(
              label: 'Jumlah Hari Kerja',
              hintText: 'Pilih hari kerja',
              value: model.selectedWorkingDays?.id, // Simpan & gunakan ID
              items: model.workingDays.map((e) => e.id).toList(), // ID untuk dropdown
              itemLabels: model.workingDays.map((e) => e.title).toList(), // Title yang ditampilkan di UI
              onChanged: (String? newValue) {
                if (newValue != null) {
                  final selected = model.workingDays.firstWhere((e) => e.id == newValue);
                  model.updateWorkingDays(selected); // Simpan ID yang dipilih
                }
              },
            ),
          const SizedBox(
            height: 24.0,
          ),
          Button.filled(
            height: 48,
            onPressed: model.isFormValid ? model.calculateOvertimes : null,
            label: 'Verifikasi',
          ),
          const SizedBox(
            height: 24.0,
          ),
          if (model.isCalculated && model.overtimeResult != null) ...[
            CalculateResultWidget(
              overtimeFormulas: model.overtimeFormulas,
              overtimeResults: model.overtimeResults,
              overtimeTotal: model.overtimeResult!,
              onReset: model.reset,
            ),
          ],
        ],
      ),
    ),
  );
}
