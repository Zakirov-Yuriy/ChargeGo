import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppTheme {
  // Private constructor
  AppTheme._();

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: Color(UIConstants.primaryGreen),
      scaffoldBackgroundColor: Colors.white,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: UIConstants.fontSizeM,
          fontFamily: 'Inter',
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.spacingL,
            vertical: UIConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusL),
          ),
          textStyle: const TextStyle(
            fontSize: UIConstants.fontSizeL,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),

      // Text theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: UIConstants.fontSizeXXL,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Inter',
        ),
        headlineMedium: TextStyle(
          fontSize: UIConstants.fontSizeXL,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(
          fontSize: UIConstants.fontSizeL,
          color: Colors.black,
          fontFamily: 'Inter',
        ),
        bodyMedium: TextStyle(
          fontSize: UIConstants.fontSizeM,
          color: Colors.black,
          fontFamily: 'Inter',
        ),
        bodySmall: TextStyle(
          fontSize: UIConstants.fontSizeS,
          color: Colors.black54,
          fontFamily: 'Inter',
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: UIConstants.spacingM,
          vertical: UIConstants.spacingM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusM),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusM),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusM),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),

      // Card theme
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(UIConstants.borderRadiusM)),
        ),
        margin: EdgeInsets.zero,
      ),
    );
  }

  // Custom colors
  static const Color primaryGreen = Color(UIConstants.primaryGreen);
  static const Color gradientStart = Color(UIConstants.gradientStart);
  static const Color gradientMiddle1 = Color(UIConstants.gradientMiddle1);
  static const Color gradientMiddle2 = Color(UIConstants.gradientMiddle2);
  static const Color gradientEnd = Color(UIConstants.gradientEnd);

  // Gradient for logo and buttons
  static LinearGradient get primaryGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          gradientStart,
          gradientMiddle1,
          gradientMiddle2,
          gradientEnd,
        ],
        stops: [0.0, 0.28, 0.62, 1.0],
      );

  // Success gradient
  static LinearGradient get successGradient => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFD9FFC4), Color(0xFF88FF61)],
      );
}

// Extension for easy access to theme colors
extension ThemeColors on BuildContext {
  Color get primaryGreen => AppTheme.primaryGreen;
  LinearGradient get primaryGradient => AppTheme.primaryGradient;
  LinearGradient get successGradient => AppTheme.successGradient;
}
