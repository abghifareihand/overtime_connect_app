import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import '../shared/app_color.dart';

class CustomTextfieldLabel extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String label;
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

  const CustomTextfieldLabel({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.borderRadius = 14.0,
    this.textCapitalization = TextCapitalization.none,
    this.helperText,
    this.maxLines = 1,
  });

  @override
  State<CustomTextfieldLabel> createState() => _CustomTextfieldLabelState();
}

class _CustomTextfieldLabelState extends State<CustomTextfieldLabel> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
            style: AppFont.semiBold.copyWith(
              color: AppColor.black,
              fontSize: 12,
            ),
            textCapitalization: widget.textCapitalization,
            controller: widget.controller,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            obscureText: widget.obscureText ? _obscureText : false,
            decoration: InputDecoration(
              hintStyle: AppFont.medium.copyWith(
                color: AppColor.gray,
                fontSize: 12,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: widget.prefixIcon,
              ),
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
                  color: AppColor.secondary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(
                  color: AppColor.secondary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(
                  color: AppColor.secondary,
                ),
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: widget.hintText,
              helperText: widget.helperText,
            ),
          ),
        ),
      ],
    );
  }
}
