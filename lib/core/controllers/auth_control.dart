import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/enums/text_field_enums.dart';
import 'providers/text_fields_provider.dart';
import '../extensions/string_extension.dart';
import '../extensions/textfied_extension.dart';
class AuthControl {
  bool registerControl(WidgetRef ref) {
   final textFieldState = ref.watch(textFieldProvider);

String username = textFieldState.getTextByEnum(TextFieldEnums.USERNAME_REGISTER);
String mail = textFieldState.getTextByEnum(TextFieldEnums.MAIL_REGISTER);
String password = textFieldState.getTextByEnum(TextFieldEnums.PASSWORD_REGISTER);
String rePassword = textFieldState.getTextByEnum(TextFieldEnums.REPASSWORD_REGISTER);
    
    /// Check if the username is empty or less than 3 characters
    if (username.isEmpty || username.length < 3) {
      debugPrint("⚠️ Username cannot be empty or less than 3 characters!");
      return false;
    }

    /// Validate email format
    if (!mail.isValidEmail) {
      debugPrint("⚠️ Invalid email address: $mail");
      return false;
    }

    /// Validate password strength
    if (!password.isValidPassword) {
      debugPrint(
          "⚠️ Your password must be at least 8 characters long and include one uppercase letter, one lowercase letter, one number, and one special character!");
      return false;
    }

    /// Check if passwords match
    if (password != rePassword) {
      debugPrint("⚠️ Passwords do not match!");
      return false;
    }

    debugPrint("✅ Entered values are valid");
    return true;
  }
}
