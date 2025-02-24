import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/extensions/context_extension.dart';

class OnboardTitleRow extends StatelessWidget {
  const OnboardTitleRow({super.key, required this.number, required this.title});
  final String number;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: context.paddingLow,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.secondary(context),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: AppFonts(context).bodySmallText,
            ),
          ),
        ),
        SizedBox(width: context.lowValue),
        Text(title, style: AppFonts(context).bodyNormalText),
      ],
    );
  }
}
