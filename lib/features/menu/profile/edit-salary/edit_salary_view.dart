import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-salary/edit_salary_view_model.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_textfield_label.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:provider/provider.dart';

class EditSalaryView extends StatelessWidget {
  final double salary;
  const EditSalaryView({
    super.key,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<EditSalaryViewModel>(
      model: EditSalaryViewModel(
        authApi: Provider.of(context),
        salary: salary,
      ),
      onModelReady: (EditSalaryViewModel model) => model.initModel(),
      onModelDispose: (EditSalaryViewModel model) => model.disposeModel(),
      builder: (BuildContext context, EditSalaryViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, EditSalaryViewModel model) {
  return CustomScaffold(
    title: 'Edit Salary',
    subtitle: 'Update pendapatan anda',
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          CustomTextfieldLabel(
            controller: model.salaryController,
            keyboardType: TextInputType.number,
            label: 'Gaji Pokok',
            hintText: 'Masukkan Gaji Pokok',
            prefixIcon: Assets.svg.icWallet.svg(),
            onChanged: model.onSalaryChanged,
          ),
          const SizedBox(
            height: 16.0,
          ),
          CustomTextfieldLabel(
            obscureText: true,
            controller: model.passwordController,
            keyboardType: TextInputType.emailAddress,
            label: 'Password',
            hintText: 'Password',
            prefixIcon: Assets.svg.icLock.svg(),
            onChanged: model.updatePasswordField,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Button.filled(
            onPressed: model.isFormValid
                ? () {
                    showLoadingDialog(context);
                    model.updateSalary(
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
                            backgroundColor: AppColor.red,
                          ),
                        );
                      },
                    );
                  }
                : null,
            label: 'Verifikasi',
          ),
        ],
      ),
    ),
  );
}
