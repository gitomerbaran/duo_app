import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  final double height;
  final double widht;
  const CustomButton(
      {super.key,
      required this.function,
      required this.text,
      required this.height,
      required this.widht});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: height,
        width: widht,
        decoration: BoxDecoration(
            color: AppColors.onBoardNickName(context),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          text,
          style: AppFonts(context).buttonText,
        )),
      ),
    );
  }
}
