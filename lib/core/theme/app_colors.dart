/*  import 'package:flutter/material.dart';

/// **Uygulamanın renk paleti**
class AppColors {
  /// **Light Mode Renkleri**
  static const Color lightPrimary = Color(0xFF6200EE);
  static const Color lightSecondary = Color(0xFF03DAC6);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF000000);
  static const Color lightButton = Color(0xFF6200EE);
  static const LinearGradient darkGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A192F), Color(0xFF112D4E)],
  );
  static const LinearGradient lightGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 196, 178, 18)
    ],
  );

  /// **Dark Mode Renkleri**
  static const Color darkPrimary = Color(0xFFBB86FC);
  static const Color darkSecondary = Color(0xFF03DAC6);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkButton = Color(0xFFBB86FC);

  /// **Light & Dark için ayrı ayrı renk şemaları**
  static final lightColorScheme = ColorScheme.light(
    primary: lightPrimary,
    secondary: lightSecondary,
    
  );

  static final darkColorScheme = ColorScheme.dark(
    primary: darkPrimary,
    secondary: darkSecondary,
    background: darkBackground,
    onBackground: darkText,
  );
}  */
import 'package:flutter/material.dart';

/// **Uygulamanın renk paleti**
class AppColors {
  static Color splashColor() => const Color(0xFF0A192F);
  static Color onBoardNickName(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;
  static Color buttonColor(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;
  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
  static Color text(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
  static const LinearGradient darkGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A192F), Color(0xFF112D4E)],
  );
  static const LinearGradient lightGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 196, 178, 18)
    ],
  );

  /// **Light Mode Renkleri**
  static final lightColorScheme = ColorScheme.light(
      primary: const Color(0xFF6200EE),
      onPrimary: const Color(0xFF6200EE),
      secondary: Colors.white,
      primaryContainer: const Color.fromARGB(255, 207, 209, 186));

  /// **Dark Mode Renkleri**
  static final darkColorScheme = ColorScheme.dark(
    primary: const Color.fromARGB(255, 231, 201, 30),
    secondary: const Color.fromARGB(255, 255, 255, 255),
    primaryContainer: const Color.fromARGB(255, 3, 4, 73),
    onPrimary: const Color.fromARGB(255, 30, 7, 160),
  );
}
