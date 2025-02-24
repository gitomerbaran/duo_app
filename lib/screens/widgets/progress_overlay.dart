import 'dart:ui';
import 'package:duo_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const ProgressOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        /// Yükleme ekranı
        if (isLoading)
          Positioned.fill(
            child: Stack(
              children: [
                /// Blur efekti ekleyen kısım
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    color: Colors.black.withAlpha(2),
                  ),
                ),

                /// Yükleme animasyonu
                Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.text(context)),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
