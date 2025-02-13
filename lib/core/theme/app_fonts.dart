import 'package:duo_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// **Uygulama içinde kullanılacak tüm font stilleri**
class AppFonts {
  final BuildContext context;

  AppFonts(this.context);
  TextStyle get headlineSmall => GoogleFonts.roboto(
        fontSize: context.lowValue,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headlineNormal => GoogleFonts.roboto(
        fontSize: context.normalValue,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headlineMedium => GoogleFonts.roboto(
        fontSize: context.mediumValue,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headlineLarge => GoogleFonts.roboto(
        fontSize: context.highValue,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyNormalText => GoogleFonts.roboto(
        fontSize: context.normalValue,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodyMediumText => GoogleFonts.roboto(
        fontSize: context.mediumValue,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodySmallText => GoogleFonts.roboto(
        fontSize: context.lowValueSecond,
        fontWeight: FontWeight.normal,
      );

  TextStyle get buttonText => GoogleFonts.roboto(
        fontSize: context.normalValue,
        fontWeight: FontWeight.w500,
      );

  TextStyle get caption => GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
