import 'package:duo_app/core/constants/enums/text_field_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/text_fields_provider.dart';
import '../extensions/string_extension.dart';

class AuthControl {
  bool registerControl(WidgetRef ref) {
    String username = ref
        .read(textFieldProvider.notifier)
        .getText(TextFieldEnums.USERNAME_REGISTER);
    String mail = ref
        .read(textFieldProvider.notifier)
        .getText(TextFieldEnums.MAIL_REGISTER);
    String password = ref
        .read(textFieldProvider.notifier)
        .getText(TextFieldEnums.PASSWORD_REGISTER);
    String rePassword = ref
        .read(textFieldProvider.notifier)
        .getText(TextFieldEnums.REPASSWORD_REGISTER);
    
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
