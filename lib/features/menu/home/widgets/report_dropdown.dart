import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class ReportDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;

  final Function(String? value)? onChanged;

  const ReportDropdown({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(
        Icons.expand_more,
        color: AppColor.white,
      ),
      dropdownColor: AppColor.primary,
      value: items.contains(value) ? value : null,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      style: AppFont.medium.copyWith(
        color: AppColor.white,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        fillColor: AppColor.primary,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
        hintStyle: AppFont.medium.copyWith(
          color: AppColor.gray,
          fontSize: 12,
        ),
        contentPadding: EdgeInsets.all(12),
      ),
    );
  }
}
