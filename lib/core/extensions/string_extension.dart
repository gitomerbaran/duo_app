import 'package:duo_app/core/constants/app/app_constants.dart';

extension StringExtension on String {
  String? get emailValidate =>
      contains(RegExp(AppConstants.EMAIL_REGEX)) ? null : "Email Failure";
}
