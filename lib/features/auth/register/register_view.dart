import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/features/auth/register/register_view_model.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_checkbox.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_textfield.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      model: RegisterViewModel(
        authApi: Provider.of(context),
      ),
      onModelReady: (RegisterViewModel model) => model.initModel(),
      onModelDispose: (RegisterViewModel model) => model.disposeModel(),
      builder: (BuildContext context, RegisterViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, RegisterViewModel model) {
  return ListView(
    children: [
      // Header
      SizedBox(
        height: 500 - 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -200,
              left: MediaQuery.of(context).size.width / 2 - 250,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Gambar di atas lingkaran
            Positioned(
              top: 80,
              child: Assets.svg.onboard3.svg(
                height: 180,
              ),
            ),
          ],
        ),
      ),

      // Title and Txtfield
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Daftar Akun',
              style: AppFont.medium.copyWith(
                color: AppColor.primary,
                fontSize: 32,
              ),
            ),
            Text(
              'Isi data akun dulu ya ...',
              style: AppFont.semiBold.copyWith(
                color: AppColor.primary,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            CustomTextfield(
              controller: model.fullnameController,
              hintText: 'Fullname',
              prefixIcon: Icon(
                Icons.person,
                color: AppColor.primary,
              ),
              onChanged: model.updateFullname,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomTextfield(
              controller: model.usernameController,
              hintText: 'Username',
              prefixIcon: Icon(
                Icons.person,
                color: AppColor.primary,
              ),
              onChanged: model.updateUsername,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomTextfield(
              controller: model.emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                color: AppColor.primary,
              ),
              onChanged: model.updateEmail,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomTextfield(
              controller: model.phoneController,
              keyboardType: TextInputType.phone,
              hintText: 'No Handphone',
              prefixIcon: Icon(
                Icons.phone,
                color: AppColor.primary,
              ),
              onChanged: model.updatePhone,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomTextfield(
              controller: model.salaryController,
              keyboardType: TextInputType.number,
              hintText: 'Gaji Pokok',
              prefixIcon: Icon(
                Icons.wallet,
                color: AppColor.primary,
              ),
              onChanged: model.updateSalary,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomTextfield(
              obscureText: true,
              controller: model.passwordController,
              hintText: 'Kata Sandi',
              prefixIcon: Icon(
                Icons.lock,
                color: AppColor.primary,
              ),
              onChanged: model.updatePassword,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomTextfield(
              obscureText: true,
              controller: model.confirmPasswordController,
              hintText: 'Ulangi Kata Sandi',
              prefixIcon: Icon(
                Icons.lock,
                color: AppColor.primary,
              ),
              onChanged: model.updateConfirmPassword,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 26.0,
            ),
            CustomCheckbox(
              value: model.isCheckbox,
              onChanged: model.toggleCheckbox,
              title: 'Saya setuju dengan Syarat & Ketentuan dan\nkebijakan Privasi yang berlaku.',
            ),
            const SizedBox(
              height: 48.0,
            ),
            Button.filled(
              onPressed: model.isFormValid
                  ? () async {
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
                      model.register(
                        success: (message) {
                          hideLoadingDialog(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuView(),
                            ),
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
                    }
                  : null,
              label: 'Buat Akun',
            ),
          ],
        ),
      ),
    ],
  );
}
