import 'package:duo_app/core/constants/enums/text_field_enums.dart';
import 'package:duo_app/core/controllers/providers/mail_valide_provider.dart';
import 'package:duo_app/core/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/navigate/navigate_constants.dart';
import '../../core/controllers/providers/text_fields_provider.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/localization/app_strings.dart';
import '../../core/navigate/navigate_services.dart';
import '../../core/theme/app_fonts.dart';
import '../widgets/button.dart';
import '../widgets/gradient_background.dart';
import '../widgets/text_button.dart';
import '../widgets/textfields.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool passwordButton = ref.watch(showPassword);
    bool repasswordButton = ref.watch(showRePassword);
    return Scaffold(
      body: Stack(
        children: [
          GradientBackgroundWidget(),
          Positioned.fill(
              child: SingleChildScrollView(
            child: Padding(
              padding: context.paddingMediumSecondHorizontal,
              child: Column(
                children: [
                  SizedBox(height: context.highValue),

                  /// Title
                  Text(
                    AppStrings.of().registerTitle!,
                    style: AppFonts(context).headlineMedium,
                  ),
                  SizedBox(height: context.mediumValue),

                  /// Username Textfield
                  CustomTextField(
                    obscureText: false,
                    onChanged: (value) {
                      ref
                          .read(textFieldProvider.notifier)
                          .updateText(TextFieldEnums.USERNAME_REGISTER, value);
                    },
                    hintText: AppStrings.of().username!,
                  ),
                  SizedBox(height: context.normalValue),

                  /// Mail textfield
                  CustomTextField(
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      ref
                          .read(textFieldProvider.notifier)
                          .updateText(TextFieldEnums.MAIL_REGISTER, value);
                    },
                    hintText: AppStrings.of().mail!,
                  ),
                  SizedBox(
                    height: context.normalValue,
                  ),

                  /// Password textfield
                  CustomTextField(
                    obscureText: !passwordButton,
                    hintText: AppStrings.of().password!,
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordButton
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        ref.read(showPassword.notifier).state =
                            !ref.read(showPassword.notifier).state;
                      },
                    ),
                    onChanged: (value) {
                      ref
                          .read(textFieldProvider.notifier)
                          .updateText(TextFieldEnums.PASSWORD_REGISTER, value);
                    },
                  ),

                  SizedBox(height: context.lowValue),

                  /// Password subtitle
                  Text(
                    AppStrings.of().passwordSubtitle!,
                    style: AppFonts(context).caption,
                  ),
                  SizedBox(height: context.normalValue),

                  /// Repassword textfield
                  CustomTextField(
                    hintText: AppStrings.of().rePassword!,
                    obscureText: !repasswordButton,
                    suffixIcon: IconButton(
                      icon: Icon(
                        repasswordButton
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        ref.read(showRePassword.notifier).state =
                            !ref.read(showRePassword.notifier).state;
                      },
                    ),
                    onChanged: (value) {
                      ref.read(textFieldProvider.notifier).updateText(
                          TextFieldEnums.REPASSWORD_REGISTER, value);
                    },
                  ),
                  SizedBox(height: context.mediumValueThird),

                  /// Register button
                  CustomButton(
                    function: () {
                      if (AuthService().registerUser(ref)) {
                        ref.invalidate(textFieldProvider);
                        NavigationService.instance.navigateToPageClear(
                          path: NavigateConstants.MAIL_VALIDATE,
                          data: ref
                              .read(mailValidateProvider.notifier)
                              .generateOtpCode(),
                        );
                      }
                    },
                    text: AppStrings.of().register!,
                    height: context.mediumValue,
                    widht: context.mediumValueWidht,
                  ),
                  SizedBox(height: context.mediumValueThird),

                  /// Login page TextButton
                  CustomTextButton(
                      underline: true,
                      function: () {
                        ref.invalidate(textFieldProvider);
                        /*  debugPrint(ref
                            .read(textFieldProvider.notifier)
                            .getText("registerPassword")); */
                        NavigationService.instance.navigateToPageClear(
                          path: NavigateConstants.LOGIN,
                        );
                      },
                      text: AppStrings.of().registerLoginTitle!),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
