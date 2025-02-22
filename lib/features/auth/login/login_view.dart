import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/features/auth/login/login_view_model.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_checkbox.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_textfield.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      model: LoginViewModel(
        authApi: Provider.of(context),
      ),
      onModelReady: (LoginViewModel model) => model.initModel(),
      onModelDispose: (LoginViewModel model) => model.disposeModel(),
      builder: (BuildContext context, LoginViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, LoginViewModel model) {
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
              child: Assets.svg.onboard2.svg(
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
              'Selamat datang',
              style: AppFont.medium.copyWith(
                color: AppColor.primary,
                fontSize: 32,
              ),
            ),
            Text(
              'Masuk dengan akun kamu',
              style: AppFont.semiBold.copyWith(
                color: AppColor.primary,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            CustomTextfield(
              controller: model.usernameController,
              hintText: 'Nama Pengguna',
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
              height: 26.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCheckbox(
                  value: model.isCheckbox,
                  onChanged: model.toggleCheckbox,
                  title: 'Ingatkan saya',
                ),
                Text(
                  'Lupa Kata Sandi?',
                  style: AppFont.regular.copyWith(
                    color: AppColor.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Button.filled(
              onPressed: model.isFormValid
                  ? () {
                      showLoadingDialog(context);
                      model.login(
                        success: (message) {
                          hideLoadingDialog(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuView(),
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
              label: 'Masuk',
            ),
          ],
        ),
      ),
    ],
  );
}
