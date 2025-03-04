import 'dart:async';
import 'package:duo_app/core/constants/enums/text_field_enums.dart';
import 'package:duo_app/core/controllers/providers/auth_provider.dart';
import 'package:duo_app/core/controllers/providers/text_fields_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/navigate/navigate_constants.dart';
import '../../core/controllers/providers/mail_valide_provider.dart';
import '../../core/dependency_injection/di.dart';
import '../../core/localization/app_strings.dart';
import '../../core/navigate/navigate_services.dart';
import '../../core/services/auth/i_auth_services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../widgets/button.dart';
import '../widgets/gradient_background.dart';
import '../widgets/text_button.dart';
import '../../core/extensions/context_extension.dart';

class MailValidationScreen extends ConsumerStatefulWidget {
  const MailValidationScreen({super.key});

  @override
  ConsumerState<MailValidationScreen> createState() =>
      _MailValidationScreenState();
}

class _MailValidationScreenState extends ConsumerState<MailValidationScreen> {
  Timer? _countdownTimer;
  int _remainingTime = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _initializeCountdown();

    // To log the Validate Code only once
    Future.microtask(() {
      debugPrint("Code: ${ref.read(mailValidateProvider.notifier).getCode}");
    });
  }

  /// timer counter
  void _initializeCountdown() {
    setState(() {
      _remainingTime = 60;
      _canResend = false;
    });

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  /// new code function
  void _onResendCode() {
    if (_canResend) {
      _initializeCountdown();
      ref.read(mailValidateProvider.notifier).regenerateOtp();
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(textFieldProvider.notifier);
    final mail = provider.getText(TextFieldEnums.MAIL_REGISTER);
    final username = provider.getText(TextFieldEnums.USERNAME_REGISTER);
    final password = provider.getText(TextFieldEnums.PASSWORD_REGISTER);

    return Scaffold(
      body: Stack(
        children: [
          const GradientBackgroundWidget(),
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: context.paddingLowHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.normalValue),
                    // close the page button
                    IconButton(
                      onPressed: () {
                        ref.invalidate(mailValidateProvider);
                        NavigationService.instance.navigateToPageClear(
                          path: NavigateConstants.LOGIN,
                        );
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(height: context.mediumValueThird),
                    // Title
                    Center(
                      child: Text(
                        AppStrings.of().mailValidateTitle!,
                        textAlign: TextAlign.center,
                        style: AppFonts(context).headlineMedium,
                      ),
                    ),
                    SizedBox(height: context.highValue),

                    /// Input
                    Center(
                      child: OtpTextField(
                        numberOfFields: 4,
                        keyboardType: TextInputType.number,
                        borderColor: AppColors.buttonColor(context),
                        enabledBorderColor: AppColors.buttonColor(context),
                        cursorColor: AppColors.secondary(context),
                        showFieldAsBox: true,
                        fieldWidth: 50,
                        alignment: Alignment.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {
                          if (verificationCode.length == 4) {
                            ref
                                .read(mailValidateProvider.notifier)
                                .updateOtpCode(verificationCode);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: context.mediumValue),
                    // Countdown and Status Information
                    Center(
                      child: Text(
                        _canResend
                            ? AppStrings.of().codeExpired!
                            : "${AppStrings.of().sendCodeTitle!} $_remainingTime ${AppStrings.of().second!}",
                        style: AppFonts(context).bodyNormalText,
                      ),
                    ),
                    SizedBox(height: context.lowValue),

                    // New code button

                    Center(
                      child: CustomTextButton(
                        color: _canResend ? null : Colors.grey,
                        underline: false,
                        function: () {
                          if (_canResend) {
                            _onResendCode();
                            debugPrint(ref
                                .read(mailValidateProvider.notifier)
                                .getCode);
                          }
                        },
                        text: AppStrings.of().sendNewCode!,
                      ),
                    ),

                    SizedBox(height: context.highValue),
                    // Validate button
                    Center(
                      child: CustomButton(
                        function: () async {
                          if (ref
                              .read(mailValidateProvider.notifier)
                              .isValidOtp()) {
                            ref
                                .read(authProvider.notifier)
                                .registerUser(mail, password, username);
                          }
                        },
                        height: context.mediumValueSecond,
                        widht: context.mediumValueWidht,
                        text: AppStrings.of().confirm!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
