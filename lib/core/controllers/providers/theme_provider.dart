import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cache/hive.dart';
import '../../dependency_injection/di.dart';
import '../theme_notifier.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(getIt<HiveSecureService>());
});
