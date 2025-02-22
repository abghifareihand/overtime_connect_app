import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';

import '../shared/app_color.dart';

class CustomTimePicker extends StatefulWidget {
  final void Function(TimeOfDay selectedTime)? onTimeSelected;
  final TimeOfDay? initialTime;
  final Widget? prefix;
  final String label;
  final bool showLabel;
  final String? hintText;
  final double borderRadius;

  const CustomTimePicker({
    super.key,
    required this.label,
    this.showLabel = true,
    this.initialTime,
    this.onTimeSelected,
    this.prefix,
    this.hintText,
    this.borderRadius = 14.0,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TextEditingController controller;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.initialTime?.format24Hour() ?? '',
    );
    selectedTime = widget.initialTime ?? TimeOfDay.now();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColor.primary,
            colorScheme: ColorScheme.light(
              primary: AppColor.primary,
              onPrimary: Colors.white,
              onSurface: AppColor.black,
            ),
            dialogBackgroundColor: AppColor.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        controller.text = selectedTime.format24Hour();
      });
      if (widget.onTimeSelected != null) {
        widget.onTimeSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: AppFont.semiBold.copyWith(
              color: AppColor.black,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6.0),
        ],
        TextFormField(
          controller: controller,
          onTap: () => _selectTime(context),
          readOnly: true,
          style: AppFont.medium.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColor.secondary),
            ),
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Assets.svg.icClock.svg(width: 20, height: 20), // Ganti dengan ikon jam
            ),
            hintText: widget.initialTime != null ? selectedTime.format24Hour() : widget.hintText ?? 'Pilih Jam',
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
