import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value; // Inisialisasi nilai awal dari parent
  }

  void _toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChanged(isChecked); // Kirim perubahan ke parent
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleCheckbox,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColor.primary, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: AppColor.primary,
                  )
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          widget.title,
          style: AppFont.regular.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
