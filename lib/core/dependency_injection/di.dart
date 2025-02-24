import 'package:get_it/get_it.dart';
import '../cache/cache_service.dart';
import '../cache/hive.dart';
import '../controllers/language_notifier.dart';
import '../controllers/theme_notifier.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final hiveService = HiveSecureService();

  await hiveService.init();

  getIt.registerSingleton<CacheService>(hiveService);
  getIt.registerSingleton<HiveSecureService>(hiveService);
  getIt.registerSingleton<LanguageNotifier>(
      LanguageNotifier(getIt<HiveSecureService>()));
    getIt.registerLazySingleton<ThemeNotifier>(() {
    return ThemeNotifier(hiveService);
  }); 
}
