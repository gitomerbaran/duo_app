import 'package:duo_app/core/cache/hive.dart';
import 'package:duo_app/screens/controllers/theme_controller.dart';
import 'package:get_it/get_it.dart';
import '../cache/cache_service.dart';
import '../../screens/controllers/language_controller.dart';

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
