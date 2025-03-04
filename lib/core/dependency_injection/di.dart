import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import '../../firebase_options.dart';
import '../cache/cache_service.dart';
import '../cache/hive.dart';
import '../controllers/notifiers/language_notifier.dart';
import '../controllers/notifiers/theme_notifier.dart';
import '../services/auth/firebase_auth_services.dart';
import '../services/i_services.dart';
import '../services/auth/i_auth_services.dart';
import '../services/firebase_services.dart';

/// **Global instance of GetIt for dependency injection**
final GetIt getIt = GetIt.instance;

/// **Registers all dependencies in GetIt**
Future<void> setupDependencies() async {
  //// Firebase initilaize ***

  // **Initialize HiveSecureService (required for dependency management)**
  final hiveService = HiveSecureService();
  await hiveService.init();

  // **Register Firebase Firestore instance**
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // **Register caching services (HiveSecureService)**
  getIt.registerSingleton<CacheService>(hiveService);
  getIt.registerSingleton<HiveSecureService>(hiveService);

  // **Register Firebase-based services**
  getIt.registerLazySingleton<IServices>(() => FirebaseService());

  // **Register AuthService as IAuthService**
  // Ensures AuthService is correctly mapped to IAuthService
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(firestore: getIt<FirebaseFirestore>()),
  );

  // **Register LanguageNotifier for language preferences**
  getIt.registerSingleton<LanguageNotifier>(
      LanguageNotifier(getIt<HiveSecureService>()));

  // **Register ThemeNotifier for theme management**
  getIt.registerLazySingleton<ThemeNotifier>(() {
    return ThemeNotifier(hiveService);
  });
}
