import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import '../shared/app_color.dart';

enum ButtonStyleType {
  filled,
  outlined,
}

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyleType.filled,
    this.color = AppColor.primary,
    this.sideColor = AppColor.primary,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 52.0,
    this.borderRadius = 14.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding,
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyleType.outlined,
    this.color = Colors.white,
    this.textColor = AppColor.primary,
    this.sideColor = AppColor.primary,
    this.width = double.infinity,
    this.height = 52.0,
    this.borderRadius = 14.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding,
  });

  final Function()? onPressed;
  final String label;
  final ButtonStyleType style;
  final Color color;
  final Color textColor;
  final Color sideColor;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool disabled;
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyleType.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                padding: padding,
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if (icon != null && label.isNotEmpty) ...[
                    icon ?? const SizedBox.shrink(),
                    const SizedBox(width: 10.0),
                  ],
                  Text(
                    label,
                    style: AppFont.semiBold.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  ),
                  if (suffixIcon != null && label.isNotEmpty) ...[
                    const SizedBox(width: 10.0),
                    suffixIcon ?? const SizedBox.shrink(),
                  ],
                ],
              ),
            )
          : OutlinedButton(
              onPressed: disabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                padding: padding,
                backgroundColor: color,
                side: BorderSide(color: sideColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if (icon != null && label.isNotEmpty) ...[
                    icon ?? const SizedBox.shrink(),
                    const SizedBox(width: 10.0),
                  ],
                  Text(
                    label,
                    style: AppFont.semiBold.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  ),
                  if (suffixIcon != null && label.isNotEmpty) ...[
                    const SizedBox(width: 10.0),
                    suffixIcon ?? const SizedBox.shrink(),
                  ],
                ],
              ),
            ),
    );
  }
}
