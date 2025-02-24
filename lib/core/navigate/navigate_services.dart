import 'package:flutter/material.dart';
import '../navigate/inavigate.dart';
class NavigationService implements INavigateServices {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  get removeAllOldRoutes => (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({String? path, Object? data}) async {

    if (navigatorKey.currentState == null) {
      
      return;
    }

    await navigatorKey.currentState!.pushNamed(path!, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async {

    if (navigatorKey.currentState == null) {
      return;
    }

    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path!, removeAllOldRoutes, arguments: data);
  }
}
