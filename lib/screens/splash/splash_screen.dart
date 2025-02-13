import 'package:duo_app/core/theme/app_colors.dart';
import 'package:duo_app/core/utils/image_manager.dart';
import 'package:flutter/material.dart';

import '../../core/init/init.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await ApplicationInitializing().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashColor(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImageManager.instance.toPng("splash.png")),
          ),
        ],
      ),
    );
  }
}
