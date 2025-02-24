import 'package:flutter/material.dart';
import '../constants/enums/language_code_enums.dart';

extension LanguageCodeExtension on LanguageCodeEnum {
  static final List<Locale> supportedLocales = [
    LanguageCodeEnum.TR.locale,
    LanguageCodeEnum.EN.locale
  ];

  String languageCodeToString() {
    switch (this) {
      case LanguageCodeEnum.TR:
        return "tr";
      case LanguageCodeEnum.EN:
        return "en";
    }
  }

  static LanguageCodeEnum stringToLanguageCode(final String value) {
    switch (value.toLowerCase()) {
      case "tr":
      case "türkçe":
        return LanguageCodeEnum.TR;
      case "en":
      case "english":
        return LanguageCodeEnum.EN;
      default:
        return LanguageCodeEnum.TR;
    }
  }
}
