import 'dart:convert';
import '../../constants/enums/language_code_enums.dart';
import '../../localization/language_code.dart';


class LanguageSettings {
  final bool isChangeSettings;
  final LanguageCodeEnum languageCode;

  LanguageSettings({
    required this.isChangeSettings,
    required this.languageCode,
  });

  factory LanguageSettings.fromJson(final String str) =>
      LanguageSettings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LanguageSettings.fromMap(final Map<String, dynamic> json) =>
      LanguageSettings(
        isChangeSettings: json["isChangeSettings"],
        languageCode:
            LanguageCodeExtension.stringToLanguageCode(json["languageCode"]),
      );

  Map<String, dynamic> toMap() => {
        "isChangeSettings": isChangeSettings,
        "languageCode": languageCode.languageCodeToString(),
      };
}