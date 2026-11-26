import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Light Palette (Figma Mockup)
  static const Color backgroundLight = Color(0xFFF6F7F9);
  static const Color slateNavy = Color(0xFF1D3547);
  static const Color accentPill = Color(0xFFC7DCEB);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF152938);
  static const Color textSecondary = Color(0xFF6E7E8B);

  // Semantic aliases for Light Theme
  static const Color background = backgroundLight;
  static const Color cardDark = slateNavy;
  static const Color cardLight = cardWhite;
  static const Color primary = slateNavy;
  static const Color secondary = accentPill;
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textMutedOnDark = Color(0xFFC7DCEB);

  // Dark Theme Variants
  static const Color backgroundDark = Color(0xFF0F1B24);
  static const Color surfaceDark = Color(0xFF172836);
  static const Color cardSlateDark = Color(0xFF1D3547);
  static const Color accentPillDark = Color(0xFF2B4C65);
  static const Color textPrimaryDark = Color(0xFFF6F7F9);
  static const Color textSecondaryDark = Color(0xFF9FB1BD);

  // Surfaces, Borders & Overlays
  static const Color cardBorderLight = Color(0xFFE6ECF1);
  static const Color cardBorderDark = Color(0xFF263B4D);
  static const Color cardShadowLight = Color(0x0D1D3547);
  static const Color progressTrackOnDark = Color(0x33FFFFFF);
  static const Color softSurfaceOnDark = Color(0x1FFFFFFF);
  static const Color iconBadgeLight = Color(0xFFEEF4F8);
  static const Color iconBadgeDark = Color(0xFF243B4E);

  // Status Colors
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color error = Color(0xFFD32F2F);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: slateNavy,
      brightness: Brightness.light,
      primary: slateNavy,
      onPrimary: cardWhite,
      secondary: accentPill,
      onSecondary: textPrimary,
      surface: cardWhite,
      onSurface: textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundLight,
      cardTheme: const CardThemeData(
        color: cardWhite,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLight,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardWhite,
        indicatorColor: accentPill,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: textPrimary);
          }
          return const IconThemeData(color: textSecondary);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          );
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: slateNavy,
      brightness: Brightness.dark,
      primary: accentPill,
      onPrimary: textPrimary,
      secondary: accentPillDark,
      onSecondary: textPrimaryDark,
      surface: surfaceDark,
      onSurface: textPrimaryDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundDark,
      cardTheme: const CardThemeData(
        color: surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: textPrimaryDark,
        elevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceDark,
        indicatorColor: accentPillDark,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: textPrimaryDark);
          }
          return const IconThemeData(color: textSecondaryDark);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: textPrimaryDark,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: textSecondaryDark,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          );
        }),
      ),
    );
  }
}
