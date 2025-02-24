import 'package:flutter/material.dart';
import '../cache/hive.dart';
import '../constants/enums/cache_enums.dart';
import '../constants/enums/theme_enums.dart';
import 'base_notifier.dart';

class ThemeNotifier extends BaseController<ThemeMode> {
  final HiveSecureService _hiveSecureService;

  ThemeNotifier(this._hiveSecureService) : super(ThemeMode.system) {
    _loadTheme();
  }

  /// **Kayıtlı temayı Hive'dan yükle**
  Future<void> _loadTheme() async {
    final savedTheme =
        await _hiveSecureService.getData(CacheEnums.THEMA_SETTINGS);

    if (savedTheme == ThemeEnums.LIGHT) {
      state = ThemeMode.light;
    } else if (savedTheme == ThemeEnums.DARK) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }

    debugPrint("Hive'dan Okunan Tema: $state ✅");
  }

  /// **Temayı değiştir ve kaydet**
  void toggleTheme() {
    state = (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;

    _hiveSecureService.addData(
        CacheEnums.THEMA_SETTINGS, state == ThemeMode.dark ? "dark" : "light");

    debugPrint("Tema Değiştirildi: $state ✅");
  }
}

