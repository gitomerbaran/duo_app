import 'package:flutter/material.dart';
import '../../core/init/init.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/image_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      await ApplicationInitializing().instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashColor(context),
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
