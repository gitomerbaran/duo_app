import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/enums/image_enums.dart';
import '../../core/constants/enums/text_field_enums.dart';
import '../../core/constants/navigate/navigate_constants.dart';
import '../../core/controllers/providers/auth_provider.dart';
import '../../core/controllers/providers/text_fields_provider.dart';
import '../../core/localization/app_strings.dart';
import '../../core/navigate/navigate_services.dart';
import '../../core/utils/image_manager.dart';
import '../widgets/button.dart';
import '../widgets/gradient_background.dart';
import '../widgets/text_button.dart';
import '../widgets/textfields.dart';
import '../../core/extensions/asset_extension.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/constants/app/app_constants.dart';
import '../../core/extensions/textfied_extension.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackgroundWidget(),
          Positioned.fill(
            child: Image.asset(
              ImageManager.instance
                  .toPng(ImageEnums.DUO_APP_ONBOARD_2.getImage),
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.15),
              colorBlendMode: BlendMode.dstATop,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.largeValueSecond),
                  Text(
                    AppConstants.APP_NAME,
                    style: GoogleFonts.openSans(
                      shadows: const [
                        Shadow(
                          blurRadius: 0.2,
                          color: Colors.white,
                          offset: Offset(2, 0),
                        )
                      ],
                      fontSize: context.height * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.mediumValue),
                  Padding(
                    padding: context.paddingHighHorizontal,
                    child: const UsernameTextField(),
                  ),
                  SizedBox(height: context.sizedBoxHeightNormal),
                  Padding(
                    padding: context.paddingHighHorizontal,
                    child: const PasswordTextField(),
                  ),
                  SizedBox(height: context.mediumValueSecond),

                  /// Login button.
                  const LoginButton(),
                  SizedBox(height: context.mediumValue),

                  /// Register page navigate button.
                  CustomTextButton(
                    underline: true,
                    function: () {
                      NavigationService.instance
                          .navigateToPage(path: NavigateConstants.REGISTER);
                    },
                    text: AppStrings.of().register!,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final username =
        ref.watch(textFieldProvider).getTextByEnum(TextFieldEnums.USERNAME);
    final password =
        ref.watch(textFieldProvider).getTextByEnum(TextFieldEnums.PASSWORD);

    return CustomButton(
      function: () async {
        final result = await authNotifier.loginUser(username, password);

        result.fold(
          /// **Başarısız giriş - Hata mesajını göster**
          (failure) => showDialog(
            context: context,
            builder: (context) => failure.errorWidget,
          ),

          (success) {
            NavigationService.instance.navigateToPage(
              path: NavigateConstants.HOME,
            );
            ref.read(textFieldProvider.notifier).resetAll();
          },
        );
      },
      text: AppStrings.of().loginButton!,
      height: context.mediumValue,
      widht: context.mediumValueWidht,
    );
  }
}

class PasswordTextField extends ConsumerWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textFieldNotifier = ref.read(textFieldProvider.notifier);

    return CustomTextField(
      hintText: AppStrings.of().password!,
      obscureText: true,
      controller: textFieldNotifier.getController(TextFieldEnums.PASSWORD),
      onChanged: (value) {
        textFieldNotifier.updateText(TextFieldEnums.PASSWORD, value);
      },
    );
  }
}

class UsernameTextField extends ConsumerWidget {
  const UsernameTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textFieldNotifier = ref.read(textFieldProvider.notifier);

    return CustomTextField(
      hintText: AppStrings.of().username!,
      obscureText: false,
      controller: textFieldNotifier.getController(TextFieldEnums.USERNAME),
      onChanged: (value) {
        textFieldNotifier.updateText(TextFieldEnums.USERNAME, value);
      },
    );
  }
}
