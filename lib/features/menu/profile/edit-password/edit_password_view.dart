import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-password/edit_password_view_model.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_textfield_label.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:provider/provider.dart';

class EditPasswordView extends StatelessWidget {
  final User user;
  const EditPasswordView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<EditPasswordViewModel>(
      model: EditPasswordViewModel(
        authApi: Provider.of(context),
        user: user,
      ),
      onModelReady: (EditPasswordViewModel model) => model.initModel(),
      onModelDispose: (EditPasswordViewModel model) => model.disposeModel(),
      builder: (BuildContext context, EditPasswordViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model, user),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, EditPasswordViewModel model, User user) {
  return CustomScaffold(
    title: 'Edit Password',
    subtitle: 'Update password demi keamanan',
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          CustomTextfieldLabel(
            obscureText: true,
            controller: model.currentPasswordController,
            keyboardType: TextInputType.emailAddress,
            label: 'Password Saat Ini',
            hintText: 'Masukkan password saat ini',
            prefixIcon: Assets.svg.icLock.svg(),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CustomTextfieldLabel(
            obscureText: true,
            controller: model.newPasswordController,
            keyboardType: TextInputType.emailAddress,
            label: 'Password Baru',
            hintText: 'Masukkan password baru',
            prefixIcon: Assets.svg.icLock.svg(),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CustomTextfieldLabel(
            obscureText: true,
            controller: model.newPasswordConfirmationController,
            keyboardType: TextInputType.emailAddress,
            label: 'Verifikasi Password Baru',
            hintText: 'Masukkan verifikasi password baru',
            prefixIcon: Assets.svg.icLock.svg(),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Button.filled(
            onPressed: () async {
              showLoadingDialog(context);
              model.updatePassword(
                success: (message) {
                  hideLoadingDialog(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuView()),
                    (Route<dynamic> route) => false,
                  );
                },
                error: (errorMessage) {
                  hideLoadingDialog(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      backgroundColor: AppColor.red,
                    ),
                  );
                },
              );
            },
            label: 'Verifikasi',
          ),
        ],
      ),
    ),
  );
}
