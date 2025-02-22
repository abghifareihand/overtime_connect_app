import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class ProfileInfo extends StatelessWidget {
  final String? fullName;
  final String role;

  const ProfileInfo({
    super.key,
    required this.fullName,
    this.role = 'Karyawan',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          fullName ?? '',
          style: AppFont.bold.copyWith(
            color: AppColor.black,
            fontSize: 16,
          ),
        ),
        Text(
          role,
          style: AppFont.medium.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
