import 'package:flutter/material.dart';
import '../cache/hive.dart';
import '../constants/enums/cache_enums.dart';
import '../constants/navigate/navigate_constants.dart';
import '../dependency_injection/di.dart';
import '../navigate/navigate_services.dart';

class ApplicationInitializing {
  get instance => _initialize();

  /// Initializing process
  Future<void> _initialize() async {
    bool data = await onboardCacheControl();

    if (data) {
      NavigationService.instance
          .navigateToPageClear(path: NavigateConstants.LOGIN);
    } else {
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
        debugPrint("❌ Hive'dan veri okuma hatası: $failure");
        return false;
      },
      (data) {
        debugPrint("✅ Hive'dan gelen veri: $data");
        return data == true;
      },
    );

    debugPrint(" Onboard Cache Değeri: $onboardStatus");

    return onboardStatus;
  }
}
