import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final List<String> itemLabels;
  final String label;
  final String hintText;
  final bool showLabel;
  final Function(String? value)? onChanged;
  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.itemLabels,
    required this.label,
    required this.hintText,
    this.onChanged,
    this.showLabel = true,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: AppFont.semiBold.copyWith(
              color: AppColor.black,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6.0),
        ],
        const SizedBox(height: 6.0),
        DropdownButtonFormField<String>(
          icon: const Icon(
            Icons.expand_more,
            color: AppColor.primary,
          ),
          dropdownColor: AppColor.white,
          value: items.contains(value) ? value : null,
          onChanged: enabled ? onChanged : null,

          // atur text sebelum user pilih dropdown
          hint: Text(
            hintText,
            style: AppFont.medium.copyWith(
              color: AppColor.gray,
              fontSize: 12,
            ),
          ),
          items: List.generate(
            items.length,
            (index) {
              return DropdownMenuItem<String>(
                value: items[index], // ID sebagai value
                child: Text(
                  itemLabels.length > index ? itemLabels[index] : items[index],
                  // Jaga-jaga jika itemLabels lebih pendek dari items
                ),
              );
            },
          ),
          style: AppFont.medium.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),

          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            hintText: value == null ? hintText : null,
            hintStyle: AppFont.medium.copyWith(
              color: AppColor.gray,
              fontSize: 12,
            ),
            contentPadding: EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
