import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cache/hive.dart';
import '../../dependency_injection/di.dart';
import '../../models/lang/language_model.dart';
import '../language_notifier.dart';

final languageNotifierProvider =
    StateNotifierProvider<LanguageNotifier, LanguageSettings>((ref) {
  return LanguageNotifier(getIt<HiveSecureService>());
});
