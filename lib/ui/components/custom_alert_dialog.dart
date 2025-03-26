import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: AppFont.semiBold.copyWith(
                color: AppColor.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Expanded(
                  child: Button.outlined(
                    height: 40,
                    borderRadius: 12,
                    onPressed: () => Navigator.pop(context),
                    label: 'Tidak',
                    textColor: AppColor.primary,
                  ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                Expanded(
                  child: Button.filled(
                    height: 40,
                    borderRadius: 12,
                    onPressed: onPressed,
                    label: 'Ya',
                    textColor: AppColor.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
