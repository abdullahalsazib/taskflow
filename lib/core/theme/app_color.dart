import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand colors
  static const Color brandPrimary = Color(0xFF1565C0);
  static const Color brandSecondary = Color(0xFF42A5F5);

  // Light palette
  static const Color lightBackground = Color(0xFFFDFBFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSoftSurface = Color(0xFFF3F1F8);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextMuted = Color(0xFF8D8A95);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightBorderSoft = Color(0xFFF0EEF4);
  static const Color lightOptionBackground = Color(0xFFFAF9FC);
  static const Color lightOptionSelectedBackground = Color(0xFFF0ECFA);
  static const Color lightShadow = Color(0x14000000);

  // Dark palette
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSoftSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF111827);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkTextMuted = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF374151);
  static const Color darkBorderSoft = Color(0xFF334155);
  static const Color darkOptionBackground = Color(0xFF1F2937);
  static const Color darkOptionSelectedBackground = Color(0xFF312E81);
  static const Color darkShadow = Color(0x4D020617);

  // Status colors
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);

  static const Color priorityHighBackground = Color(0xFFFFE7EF);
  static const Color priorityHighForeground = Color(0xFFE86D96);
  static const Color priorityMediumBackground = Color(0xFFFFF0D8);
  static const Color priorityMediumForeground = Color(0xFFE5A83B);
  static const Color priorityLowBackground = Color(0xFFE2F8EF);
  static const Color priorityLowForeground = Color(0xFF37B982);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6254E7), Color(0xFF27C7DD)],
  );

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color background(BuildContext context) {
    return isDark(context) ? darkBackground : lightBackground;
  }

  static Color surface(BuildContext context) {
    return isDark(context) ? darkSurface : lightSurface;
  }

  static Color softSurface(BuildContext context) {
    return isDark(context) ? darkSoftSurface : lightSoftSurface;
  }

  static Color card(BuildContext context) {
    return isDark(context) ? darkCard : lightCard;
  }

  static Color textPrimary(BuildContext context) {
    return isDark(context) ? darkTextPrimary : lightTextPrimary;
  }

  static Color textSecondary(BuildContext context) {
    return isDark(context) ? darkTextSecondary : lightTextSecondary;
  }

  static Color textMuted(BuildContext context) {
    return isDark(context) ? darkTextMuted : lightTextMuted;
  }

  static Color border(BuildContext context) {
    return isDark(context) ? darkBorder : lightBorder;
  }

  static Color borderSoft(BuildContext context) {
    return isDark(context) ? darkBorderSoft : lightBorderSoft;
  }

  static Color optionBackground(BuildContext context) {
    return isDark(context) ? darkOptionBackground : lightOptionBackground;
  }

  static Color optionSelectedBackground(BuildContext context) {
    return isDark(context)
        ? darkOptionSelectedBackground
        : lightOptionSelectedBackground;
  }

  static Color shadow(BuildContext context) {
    return isDark(context) ? darkShadow : lightShadow;
  }
}

class AppThemes {
  AppThemes._();

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      dialogTheme: const DialogThemeData(backgroundColor: Colors.transparent),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF4B4B94),
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.lightTextMuted),
        filled: true,
        fillColor: AppColors.lightSoftSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.brandPrimary),
        ),
      ),
    );
  }

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      dialogTheme: const DialogThemeData(backgroundColor: Colors.transparent),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF4338CA),
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.darkTextMuted),
        filled: true,
        fillColor: AppColors.darkSoftSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.brandSecondary),
        ),
      ),
    );
  }
}
