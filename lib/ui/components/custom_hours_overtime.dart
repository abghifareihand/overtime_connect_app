import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/formatters.dart';

class CustomHoursOvertime extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String value)? onChanged;
  final bool readOnly;
  const CustomHoursOvertime({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.readOnly = false,
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
        Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColor.primary, // Warna kursor
              selectionColor: AppColor.primary.withValues(alpha: 0.2), // Warna highlight
              selectionHandleColor: AppColor.primary, // Warna handle (ujung selection)
            ),
          ),
          child: TextFormField(
            readOnly: readOnly ? true : false,
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
              suffixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  'Jam',
                  style: AppFont.medium.copyWith(
                    color: AppColor.primary,
                    fontSize: 12,
                  ),
                ),
              ),
              hintText: 'Masukkan Jam Lembur',
              hintStyle: AppFont.medium.copyWith(
                color: AppColor.gray,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
