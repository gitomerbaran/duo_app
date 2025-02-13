import 'package:duo_app/core/cache/hive.dart';
import 'package:duo_app/core/constants/enums/cache_enums.dart';
import 'package:duo_app/core/constants/enums/theme_enums.dart';
import 'package:duo_app/core/dependency_injection/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final HiveSecureService _hiveSecureService;

  ThemeNotifier(this._hiveSecureService) : super(ThemeMode.system) {
    _loadTheme(); // 🔹 Uygulama açıldığında kayıtlı temayı yükle
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

    print("Hive'dan Okunan Tema: $state ✅");
  }

  /// **Temayı değiştir ve kaydet**
  void toggleTheme() {
    state = (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;

    _hiveSecureService.addData(
        CacheEnums.THEMA_SETTINGS, state == ThemeMode.dark ? "dark" : "light");

    print("Tema Değiştirildi: $state ✅");
  }
}

/// **Riverpod için Tema Sağlayıcı**
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(getIt<HiveSecureService>());
});
