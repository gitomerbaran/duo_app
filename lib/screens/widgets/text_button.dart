import 'package:flutter/material.dart';
import '../../core/theme/app_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  final bool underline;
  final Color? color;
  const CustomTextButton(
      {super.key,
      this.color,
      required this.function,
      required this.text,
      required this.underline});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Text(
        text,
        style: AppFonts(context).bodySmallText.copyWith(
              decoration: underline ? TextDecoration.underline : null,
              decorationThickness: 1,
              color: color,
            ),
      ),
    );
  }
}
