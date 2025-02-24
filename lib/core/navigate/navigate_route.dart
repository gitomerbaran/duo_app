import 'package:duo_app/screens/register/mail_validation_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/onboard/onboard.dart';
import '../../screens/register/register_screen.dart';
import '../../screens/splash/splash_screen.dart';
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

      case NavigateConstants.HOME:
        return normalNavigation(const HomeScreen());

      case NavigateConstants.REGISTER:
        return normalNavigation(const RegisterScreen());

      case NavigateConstants.MAIL_VALIDATE:
        return normalNavigation(const MailValidationScreen());

      default:
        return CupertinoPageRoute(builder: (context) => const NotFoundPage());
    }
  }

  CupertinoPageRoute normalNavigation(Widget widget) {
    return CupertinoPageRoute(builder: (context) => widget);
  }
}
