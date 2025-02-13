import 'package:duo_app/core/cache/hive.dart';
import 'package:duo_app/core/dependency_injection/di.dart';
import 'package:duo_app/core/extensions/context_extension.dart';
import 'package:duo_app/core/utils/image_manager.dart';
import 'package:duo_app/screens/widgets/button.dart';
import 'package:duo_app/screens/widgets/textfields.dart';
import 'package:duo_app/core/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0A192F), Color(0xFF112D4E)],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              ImageManager.instance.toPng("duo_app_onboard.webp"),
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.15),
              colorBlendMode: BlendMode.dstATop,
            ),
          ),
          Positioned(
            top: context.highValue * 2.5,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Duo Uygulaması",
                  style: GoogleFonts.openSans(
                    shadows: [
                      const Shadow(
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
                SizedBox(height: context.sizedBoxHeightMedium * 1.5),
                Padding(
                  padding: context.paddingHighHorizontal,
                  child: CustomTextFields(
                    hintText: "Kullanıcı Adı",
                    obscure: false,
                  ),
                ),
                SizedBox(height: context.sizedBoxHeightNormal),
                Padding(
                  padding: context.paddingHighHorizontal,
                  child: CustomTextFields(
                    hintText: "Şifre",
                    obscure: true,
                  ),
                ),
                SizedBox(height: context.sizedBoxHeightHigh / 1.5),
                CustomButton(
                    function: () {
                      getIt<HiveSecureService>().clearAll();
                    },
                    text: AppStrings.of().loginButton!,
                    height: context.mediumValue,
                    widht: context.mediumValueWidht)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
