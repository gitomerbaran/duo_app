import 'dart:convert';
import 'package:duo_app/screens/controllers/language_controller.dart';
import 'package:duo_app/core/dependency_injection/di.dart';
import 'package:duo_app/core/navigate/navigate_services.dart';
import 'package:duo_app/core/localization/app_strings_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStrings {
  final Locale _locale;
  Map<String, String> _localizedStrings = const {};
  static const LocalizationsDelegate<AppStrings> delegate =
      AppStringsDelegate();
  AppStrings(this._locale);
  static AppStrings of() => Localizations.of<AppStrings>(
          NavigationService.instance.navigatorKey.currentContext!, AppStrings)
      as AppStrings;

  /// Load strings with serviceLocator
  Future<void> loadStrings() async {
    await getIt<LanguageNotifier>().init(deviceLocalLanguage: _locale);
    final languageProv = getIt<LanguageNotifier>();
    String jsonString;
    if (languageProv.isSettingsChange()) {
      jsonString = await rootBundle.loadString(
          "assets/langs/${languageProv.getLanguageCodeName()}.json");
    } else {
      jsonString = await rootBundle
          .loadString("assets/langs/${_locale.languageCode}.json");
    }
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map(
      (final key, final value) => MapEntry(key,
          value.toString().isEmpty ? "Çeviri Yapılamadı" : value.toString()),
    );
  }

  String? get title => _localizedStrings['title'];
  String? get username => _localizedStrings['username'];
  String? get password => _localizedStrings['password'];
  String? get loginButton => _localizedStrings['loginButton'];
  String? get onboardHeadLine => _localizedStrings['onboardHeadLine'];

  String? get onboardFirstTitle => _localizedStrings['onboardFirstTitle'];
  String? get onboardSecondtTitle => _localizedStrings['onboardSecondtTitle'];
  String? get onboardThirdTitle => _localizedStrings['onboardThirdTitle'];
  String? get onboardFourthTitle => _localizedStrings['onboardFourthTitle'];
  String? get nextText => _localizedStrings['nextText'];
  String? get onboardSkipPageTitle => _localizedStrings['onboardSkipPageTitle'];
    String? get lolDiamondRank => _localizedStrings['lolDiamondRank'];
      String? get lolMasterRank => _localizedStrings['lolMasterRank'];

  String? get lolGrandMasterRank => _localizedStrings['lolGrandMasterRank'];
    String? get findTeam => _localizedStrings['findTeam'];



}
