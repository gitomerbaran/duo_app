import 'package:duo_app/screens/login/login_screen.dart';
import 'package:duo_app/screens/onboard/onboard.dart';
import 'package:duo_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../screens/widgets/not_found_page.dart';
import '../constants/navigate/navigate_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;
  NavigationRoute._init();

  Route<dynamic> generateRoute(args) {
    switch (args.name) {
      case NavigateConstants.DEFAULT:
        return normalNavigation(const SplashScreen());

      case NavigateConstants.LOGIN:
        return normalNavigation(const LoginScreen());

      case NavigateConstants.ONBOARD:
        return normalNavigation(const OnboardScreen());
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
    }
  }

  MaterialPageRoute normalNavigation(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
