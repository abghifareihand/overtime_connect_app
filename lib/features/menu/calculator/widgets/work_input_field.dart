import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/formatters.dart';

class WorkInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final String suffixText;
  final TextEditingController controller;
  final void Function(String value)? onChanged;
  const WorkInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.suffixText,
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
        Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColor.primary, // Warna kursor
              selectionColor: AppColor.primary.withValues(alpha: 0.2), // Warna highlight
              selectionHandleColor: AppColor.primary, // Warna handle (ujung selection)
            ),
          ),
          child: TextFormField(
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
              contentPadding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 14,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  suffixText,
                  style: AppFont.medium.copyWith(
                    color: AppColor.black,
                    fontSize: 12,
                  ),
                ),
              ),
              hintText: hintText,
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
