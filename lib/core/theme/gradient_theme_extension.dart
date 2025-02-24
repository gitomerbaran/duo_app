import 'package:flutter/material.dart';

/// Gradient extension add to Theme class in Theme Extension
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
    
   
    // If result is null return to default value
    return GradientTheme(
      backgroundGradient: LinearGradient.lerp(
            backgroundGradient, 
            other.backgroundGradient, 
            t
          ) ?? backgroundGradient, 
    );
  }
}
