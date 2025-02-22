import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final Widget child;

  const CustomScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.only(
            top: 40,
            left: 16,
            right: 16,
          ),
          color: AppColor.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (showBackButton)
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  if (showBackButton) const SizedBox(width: 4),
                  Text(
                    title,
                    style: AppFont.bold.copyWith(
                      color: AppColor.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              if (showBackButton)
                Padding(
                  padding: EdgeInsets.only(
                    left: showBackButton ? 30 : 0,
                  ),
                  child: Text(
                    subtitle!,
                    style: AppFont.regular.copyWith(
                      color: AppColor.white,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.only(top: 100.0),
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28.0),
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
