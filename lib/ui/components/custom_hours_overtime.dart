import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/formatters.dart';

class CustomHoursOvertime extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String value)? onChanged;
  const CustomHoursOvertime({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFont.semiBold.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          cursorColor: AppColor.primary,
          controller: controller,
          onChanged: onChanged,
          style: AppFont.medium.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [DoubleInputFormatter()],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Assets.svg.icClock.svg(width: 20, height: 20),
            ),
            suffixText: 'Jam',
            suffixStyle: AppFont.semiBold.copyWith(
              color: AppColor.primary,
              fontSize: 12,
            ),
            hintText: 'Masukkan Jam Lembur',
            hintStyle: AppFont.medium.copyWith(
              color: AppColor.gray,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
