import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/features/auth/login/login_view.dart';
import 'package:overtime_connect_app/features/auth/onboarding/onboarding_view_model.dart';
import 'package:overtime_connect_app/features/auth/register/register_view.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardingViewModel>(
      model: OnboardingViewModel(),
      onModelReady: (OnboardingViewModel model) => model.initModel(),
      onModelDispose: (OnboardingViewModel model) => model.disposeModel(),
      builder: (BuildContext context, OnboardingViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, OnboardingViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.primary,
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Expanded 1 : Image
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.svg.onboard1.svg(),
              ],
            ),
          ),

          // Expanded 2 ; Ttile dan Desc
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Overtime Connect',
                  style: AppFont.bold.copyWith(
                    color: AppColor.primary,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Hitung dan ketahui seberapa besar\npenghasilan mu bulan ini',
                  style: AppFont.semiBold.copyWith(
                    color: AppColor.primary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Expanded 3 : Button
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ),
                    );
                  },
                  label: 'Masuk',
                ),
                const SizedBox(height: 16.0),
                Button.outlined(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterView(),
                      ),
                    );
                  },
                  label: 'Daftar Akun',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
