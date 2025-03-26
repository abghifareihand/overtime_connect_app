import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/auth/forgot-password/forgot_password_view_model.dart';
import 'package:overtime_connect_app/features/auth/login/login_view.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_textfield.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      model: ForgotPasswordViewModel(
        authApi: Provider.of(context),
      ),
      onModelReady: (ForgotPasswordViewModel model) => model.initModel(),
      onModelDispose: (ForgotPasswordViewModel model) => model.disposeModel(),
      builder: (BuildContext context, ForgotPasswordViewModel model, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.white,
          ),
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, ForgotPasswordViewModel model) {
  return ListView(
    children: [
      if (model.index == 1) _buildFormOtpEmail(context, model),
      if (model.index == 2) _buildFormResetPassword(context, model),
    ],
  );
}

Widget _buildFormOtpEmail(BuildContext context, ForgotPasswordViewModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reset Password',
          style: AppFont.medium.copyWith(
            color: AppColor.primary,
            fontSize: 22,
          ),
        ),
        Text(
          'Masukkan email aktif untuk reset password',
          style: AppFont.medium.copyWith(
            color: AppColor.gray,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        CustomTextfield(
          controller: model.emailController,
          hintText: 'Masukkan Email',
          prefixIcon: Icon(
            Icons.email,
            color: AppColor.primary,
          ),
          onChanged: model.updateEmail,
        ),
        const SizedBox(
          height: 48.0,
        ),
        Button.filled(
          onPressed: model.isFormOtpValid
              ? () {
                  showLoadingDialog(context);
                  model.requestOtp(
                    success: (message) {
                      hideLoadingDialog(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.green,
                        ),
                      );
                      model.setToNextTab();
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
          label: 'Kirim OTP',
        ),
      ],
    ),
  );
}

Widget _buildFormResetPassword(BuildContext context, ForgotPasswordViewModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buat Password Baru',
          style: AppFont.medium.copyWith(
            color: AppColor.primary,
            fontSize: 22,
          ),
        ),
        Text(
          'Silakan buat password baru untuk akun Anda',
          style: AppFont.medium.copyWith(
            color: AppColor.gray,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        CustomTextfield(
          controller: model.otpController,
          keyboardType: TextInputType.number,
          hintText: 'Masukkan Kode OTP',
          prefixIcon: Icon(
            Icons.phone_android,
            color: AppColor.primary,
          ),
          onChanged: model.updateOtp,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextfield(
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          controller: model.passwordController,
          hintText: 'Masukkan Password Baru',
          prefixIcon: Icon(
            Icons.lock,
            color: AppColor.primary,
          ),
          onChanged: model.updatePassword,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextfield(
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          controller: model.passwordConfirmController,
          hintText: 'Konfirmasi Password Baru',
          prefixIcon: Icon(
            Icons.lock,
            color: AppColor.primary,
          ),
          onChanged: model.updatePasswordConfirm,
        ),
        const SizedBox(
          height: 48.0,
        ),
        Button.outlined(
          onPressed: () {
            model.setToPrevTab();
          },
          label: 'Kembali',
        ),
        const SizedBox(
          height: 12.0,
        ),
        Button.filled(
          onPressed: model.isFormResetValid
              ? () {
                  if (!model.isPasswordMatch) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Kata sandi dan konfirmasi kata sandi tidak cocok'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  showLoadingDialog(context);
                  model.resetPassword(
                    success: (message) {
                      hideLoadingDialog(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
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
          label: 'Reset Password',
        ),
      ],
    ),
  );
}
