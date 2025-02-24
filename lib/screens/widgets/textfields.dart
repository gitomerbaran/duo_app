import 'package:flutter/material.dart';
import '../../core/theme/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color borderColor;
  final Function(String)? onChanged;
  final Function()? onTapSuffix;
  final TextInputType? keyboardType;

  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.borderColor = Colors.grey,
      this.onChanged,
      this.onTapSuffix,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppFonts(context).bodySmallText,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts(context).bodySmallText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }
}
