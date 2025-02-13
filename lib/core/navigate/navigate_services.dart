import 'package:duo_app/core/navigate/inavigate.dart';
import 'package:flutter/material.dart';

class NavigationService implements INavigateServices {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  get removeAllOldRoutes => (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({String? path, Object? data}) async {
    print("🛑 NavigationService: Yönlendirme yapılıyor -> $path");

    if (navigatorKey.currentState == null) {
      
      return;
    }

    await navigatorKey.currentState!.pushNamed(path!, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async {
    print("🛑 NavigationService: Sayfa temizlenerek yönlendiriliyor -> $path");

    if (navigatorKey.currentState == null) {
      print(
          "❌ HATA: navigatorKey.currentState NULL olduğu için yönlendirme başarısız!");
      return;
    }

    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path!, removeAllOldRoutes, arguments: data);
  }
}
