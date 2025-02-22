import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-email/edit_email_view_model.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_textfield_label.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:provider/provider.dart';

class EditEmailView extends StatelessWidget {
  final User user;
  const EditEmailView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<EditEmailViewModel>(
      model: EditEmailViewModel(
        authApi: Provider.of(context),
        user: user,
      ),
      onModelReady: (EditEmailViewModel model) => model.initModel(),
      onModelDispose: (EditEmailViewModel model) => model.disposeModel(),
      builder: (BuildContext context, EditEmailViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model, user),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, EditEmailViewModel model, User user) {
  return CustomScaffold(
    title: 'Edit Email',
    subtitle: 'Update email yang akan dipakai',
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          CustomTextfieldLabel(
            controller: model.emailController,
            keyboardType: TextInputType.emailAddress,
            label: 'Email Terbaru',
            hintText: 'Email Terbaru',
            prefixIcon: Assets.svg.icEmail.svg(),
            onChanged: model.updateEmailField,
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
                    model.updateEmail(
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
