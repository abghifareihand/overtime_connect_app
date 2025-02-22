import 'dart:io';
import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class CustomUpload extends StatelessWidget {
  final String label;
  final File? imageFile;
  final Function()? onTap;
  const CustomUpload({
    super.key,
    required this.label,
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFont.bold.copyWith(
            color: AppColor.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.gray),
          ),
          child: imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(
                  Icons.image,
                  color: AppColor.gray.withValues(alpha: 0.5),
                  size: 48,
                ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onTap,
            child: Text(
              'Select Photo',
              style: AppFont.medium.copyWith(
                color: AppColor.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
