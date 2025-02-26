import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import '../shared/app_color.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final void Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final double borderRadius;
  final TextCapitalization textCapitalization;
  final String? helperText;
  final int maxLines;

  const CustomTextfield({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.borderRadius = 10.0,
    this.textCapitalization = TextCapitalization.none,
    this.helperText,
    this.maxLines = 1,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.primary, // Warna kursor
          selectionColor: AppColor.primary.withValues(alpha: 0.2), // Warna highlight
          selectionHandleColor: AppColor.primary, // Warna handle (ujung selection)
        ),
      ),
      child: TextFormField(
        cursorColor: AppColor.primary,
        style: AppFont.semiBold.copyWith(
          color: AppColor.primary,
          fontSize: 16,
        ),
        textCapitalization: widget.textCapitalization,
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText ? _obscureText : false,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          hintStyle: AppFont.medium.copyWith(
            color: AppColor.gray,
            fontSize: 16,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColor.primary,
                  ),
                  onPressed: _toggleObscureText,
                )
              : widget.suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: AppColor.disable,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: AppColor.disable,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: AppColor.primary,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: widget.hintText,
          helperText: widget.helperText,
        ),
      ),
    );
  }
}
