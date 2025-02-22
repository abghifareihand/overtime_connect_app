import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/auth/splash/splash_view_model.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      model: SplashViewModel(),
      onModelReady: (SplashViewModel model) => model.checkLogin(context),
      onModelDispose: (SplashViewModel model) => model.disposeModel(),
      builder: (BuildContext context, SplashViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, SplashViewModel model) {
  return Center(
    child: Text(
      'Overtime Connect',
      style: AppFont.bold.copyWith(
        color: AppColor.primary,
        fontSize: 32,
      ),
    ),
  );
}
