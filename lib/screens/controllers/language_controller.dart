import 'dart:io';
import 'package:duo_app/core/cache/hive.dart';
import 'package:duo_app/core/constants/enums/cache_enums.dart';
import 'package:duo_app/core/constants/enums/language_code_enums.dart';
import 'package:duo_app/core/dependency_injection/di.dart';
import 'package:duo_app/core/errors/failure_types/failure_types.dart';
import 'package:duo_app/core/localization/app_strings.dart';
import 'package:duo_app/core/localization/language_code.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../core/models/lang/language_model.dart';

class LanguageNotifier extends StateNotifier<LanguageSettings> {
  LanguageNotifier(this._hiveSecureService)
      : super(LanguageSettings(
            isChangeSettings: false, languageCode: LanguageCodeEnum.TR));
  late Map<LanguageCodeEnum, bool> supportedLanguages;
  late LanguageSettings _languageSettings;

  /// Secure storage keys
  final HiveSecureService _hiveSecureService;

  Future<void> init({Locale? deviceLocalLanguage}) async {
    final languageSettingsEither =
        await _hiveSecureService.getData(CacheEnums.LANGUAGE_SETTINGS);

    await languageSettingsEither.fold(
      (failure) async => await _setDefaultLanguageSettings(deviceLocalLanguage),
      (data) => _languageSettings = LanguageSettings.fromJson(data),
    );

    _createSupportedLanguageMap();
  }

  Future<void> _setDefaultLanguageSettings(Locale? deviceLocalLanguage) async {
    final languageCode = LanguageCodeExtension.stringToLanguageCode(
      deviceLocalLanguage?.languageCode ?? Platform.localeName.substring(0, 2),
    );
    _languageSettings = LanguageSettings(
      isChangeSettings: false,
      languageCode: languageCode,
    );

    await _hiveSecureService.addData(
        CacheEnums.LANGUAGE_SETTINGS, _languageSettings.toJson());
  }

  Future<void> changeLanguage(LanguageCodeEnum languageCode) async {
    _updateLanguageSettings(languageCode);

    final saveLanguageEither = await _hiveSecureService.addData(
        CacheEnums.LANGUAGE_SETTINGS, _languageSettings.toJson());

    saveLanguageEither.fold(
      (failure) {
        LanguageFailure("Language Error");
      }, // Hata işleme (UI'da bildirim yapılabilir)
      (success) => _createSupportedLanguageMap(),
    );

    await AppStrings.of().loadStrings();
  }

  //language update
  void _updateLanguageSettings(LanguageCodeEnum languageCode) {
    _languageSettings = LanguageSettings(
      isChangeSettings: true,
      languageCode: languageCode,
    );
  }

  /// Desteklenen diller ve seçili olan dilin durumunu tutan Map oluşturma
  void _createSupportedLanguageMap() {
    supportedLanguages = {
      LanguageCodeEnum.TR:
          _languageSettings.languageCode == LanguageCodeEnum.TR,
      LanguageCodeEnum.EN:
          _languageSettings.languageCode == LanguageCodeEnum.EN,
    };
  }

  bool isSettingsChange() => _languageSettings.isChangeSettings;

  String getLanguageCodeName() =>
      _languageSettings.languageCode.languageCodeToString();

  LanguageCodeEnum getLanguageCode() => _languageSettings.languageCode;
}

final languageNotifierProvider =
    StateNotifierProvider<LanguageNotifier, LanguageSettings>((ref) {
  return LanguageNotifier(getIt<HiveSecureService>());
});
