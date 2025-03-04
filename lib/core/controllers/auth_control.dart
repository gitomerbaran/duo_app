import 'package:duo_app/core/constants/enums/text_field_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/text_fields_provider.dart';
import '../extensions/string_extension.dart';

class AuthControl{
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

    if (username.isEmpty || username.length < 3) {
      debugPrint("⚠️ Kullanıcı adı boş veya 3 karakterden küçük olamaz!");
      return false;
    }

    if (!mail.isValidEmail) {
      debugPrint("⚠️ Geçersiz e-posta adresi: $mail");
      return false;
    }

    if (!password.isValidPassword) {
      debugPrint(
          "⚠️ Şifreniz en az 8 karakter, bir büyük harf, bir küçük harf, bir rakam ve bir özel karakter içermelidir!");
      return false;
    }

    if (password != rePassword) {
      debugPrint("⚠️ Şifreler uyuşmuyor!");
      return false;
    }

    debugPrint("✅ Kayıt başarılı!");
    return true;
  }
}
