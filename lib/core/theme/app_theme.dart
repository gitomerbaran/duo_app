import 'package:flutter/material.dart';
import 'app_fonts.dart';
import 'app_colors.dart';
import 'gradient_theme_extension.dart';

/// **Uygulama Teması**
class AppTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
              colorScheme: AppColors.lightColorScheme,
              brightness: Brightness.light,
              textTheme: TextTheme(
                headlineLarge: AppFonts(context).headlineLarge,
                headlineMedium: AppFonts(context).headlineMedium,
                bodyLarge: AppFonts(context).bodyNormalText,
                labelLarge: AppFonts(context).buttonText,
              ),
              cardColor: AppColors.lightColorScheme.onPrimary)
          .copyWith(
        extensions: [
          GradientTheme(
            backgroundGradient: AppColors.lightGradientBackground,
          ),
        ],
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        colorScheme: AppColors.darkColorScheme,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headlineLarge: AppFonts(context).headlineLarge,
          headlineMedium: AppFonts(context).headlineMedium,
          bodyLarge: AppFonts(context).bodyNormalText,
          labelLarge: AppFonts(context).buttonText,
        ),
      ).copyWith(
        extensions: [
          GradientTheme(
            backgroundGradient: AppColors.darkGradientBackground,
          ),
        ],
      );

  static Gradient getGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final gradientTheme = Theme.of(context).extension<GradientTheme>();

    return gradientTheme?.backgroundGradient ??
        (brightness == Brightness.dark
            ? AppColors.darkGradientBackground
            : AppColors.lightGradientBackground);
  }
}
