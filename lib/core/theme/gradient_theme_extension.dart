import 'package:flutter/material.dart';

/// **Gradient için ThemeExtension Tanımı**
class GradientTheme extends ThemeExtension<GradientTheme> {
  final LinearGradient backgroundGradient;

  GradientTheme({required this.backgroundGradient});

  @override
  ThemeExtension<GradientTheme> copyWith({LinearGradient? backgroundGradient}) {
    return GradientTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  ThemeExtension<GradientTheme> lerp(
      ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;
    
    // Eğer null dönerse, varsayılan olarak mevcut backgroundGradient'i döndür.
    return GradientTheme(
      backgroundGradient: LinearGradient.lerp(
            backgroundGradient, 
            other.backgroundGradient, 
            t
          ) ?? backgroundGradient, 
    );
  }
}
