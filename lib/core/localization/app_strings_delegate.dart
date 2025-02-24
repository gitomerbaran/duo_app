import 'package:duo_app/core/localization/_localization_exports.dart';
import 'package:flutter/material.dart';
import '../constants/enums/language_code_enums.dart';

class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) {
    return LanguageCodeEnum.values
        .map((e) => e.locale.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppStrings> load(Locale locale) async {
    final appLocalization = AppStrings(locale);
    await appLocalization
        .loadStrings(); // ✅ Çeviri dosyalarını yüklemeyi unutma!
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppStrings> old) => false;
}
