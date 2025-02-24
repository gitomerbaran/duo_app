import '../constants/app/app_constants.dart';

extension StringExtension on String {
  bool get isValidEmail => RegExp(AppConstants.MAIL_REGEX).hasMatch(this);

  bool get isValidPassword =>
      RegExp(AppConstants.PASSWORD_REGEX).hasMatch(this);
}
