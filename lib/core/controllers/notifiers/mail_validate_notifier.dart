import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mail_validate_model.dart';

class MailValidateNotifier extends StateNotifier<MailValideModel> {
  MailValidateNotifier() : super(MailValideModel()) {
    regenerateOtp(); // Generate OTP when object is created
  }
  String get getCode => state.otpCode;

  /// Random code generator
  String generateOtpCode() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  /// user input
  void updateOtpCode(String code) {
    state = state.copyWith(enteredCode: code);
  }

  /// New code generator
  void regenerateOtp() {
    /// service code  will be added

    state = state.copyWith(otpCode: generateOtpCode(), enteredCode: "");
  }

  /// validation
  bool isValidOtp() {
    return state.enteredCode == state.otpCode;
  }
}
