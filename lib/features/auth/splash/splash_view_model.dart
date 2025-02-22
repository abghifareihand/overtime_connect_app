import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/services/pref_service.dart';
import 'package:overtime_connect_app/features/auth/onboarding/onboarding_view.dart';
import 'package:overtime_connect_app/features/base_view_model.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';

class SplashViewModel extends BaseViewModel {
  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    final token = await PrefService.getToken();
    log('TOKEN : $token');
    if (context.mounted) {
      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MenuView(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingView(),
          ),
        );
      }
    }
  }
}
