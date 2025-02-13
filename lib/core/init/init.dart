import 'package:duo_app/core/cache/hive.dart';
import 'package:duo_app/core/constants/enums/cache_enums.dart';
import 'package:duo_app/core/constants/navigate/navigate_constants.dart';
import 'package:duo_app/core/dependency_injection/di.dart';
import 'package:duo_app/core/navigate/navigate_services.dart';

class ApplicationInitializing {
  /// Singleton Instance
  static final ApplicationInitializing _instance =
      ApplicationInitializing._internal();

  /// Singleton Factory
  factory ApplicationInitializing() => _instance;

  /// Private Constructor
  ApplicationInitializing._internal();

  /// Uygulama Başlangıç İşlemleri
  Future<void> initialize() async {
    bool data = await onboardCacheControl();

    print(
        "📍 Yönlendirilen Sayfa: ${data ? NavigateConstants.LOGIN : NavigateConstants.ONBOARD}");

    if (data) {
      print("🔵 LOGIN sayfasına yönlendiriliyor...");
      NavigationService.instance
          .navigateToPageClear(path: NavigateConstants.LOGIN);
    } else {
      print("🟠 ONBOARD sayfasına yönlendiriliyor...");
      NavigationService.instance
          .navigateToPageClear(path: NavigateConstants.ONBOARD);
    }
  }

  /// If the application is opened for the first time, it will return false

  Future<bool> onboardCacheControl() async {
    final result = await getIt<HiveSecureService>()
        .getData<bool>(CacheEnums.ONBOARD_CONTROL);

    bool onboardStatus = result.fold(
      (failure) {
        print("❌ Hive'dan veri okuma hatası: $failure");
        return false;
      },
      (data) {
        print("✅ Hive'dan gelen veri: $data");
        return data == true;
      },
    );

    print("🧐 Onboard Cache Değeri: $onboardStatus"); // Log ekledik

    return onboardStatus;
  }
}
