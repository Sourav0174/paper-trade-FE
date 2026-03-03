import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color lightPrimary = Color(0xFF081C15);
  // static const Color lightOnPrimary = Color(0xFFFFFFFF);
  // static const Color lightBackground = Color(0xFFFFFFFF);
  // static const Color lightSurface = Color(0xFFFFFFFF);
  // static const Color lightPrimaryText = Color(0xFF0A0A0F);
  // static const Color lightSecondaryText = Color(0xFF44444F);
  // static const Color lightDivider = Color(0xFFC6C6D0);
  // static const Color lightSuccess = Color(0xFF4ADE80);
  // static const Color lightError = Color(0xFFFF3B3B);
  // static const Color lightHint = Color(0xFF75757F);
  // Light Mode
  // static const Color lightPrimary = Color(0xFF0066FF);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimaryText = Color(0xFF0A0A0F);
  static const Color lightSecondaryText = Color(0xFF44444F);
  static const Color lightDivider = Color(0xFFC6C6D0);
  static const Color lightSuccess = Color(0xFF2D6A4F);
  static const Color lightError = Color(0xFFFF3B3B);
  static const Color lightHint = Color(0xFF75757F);

  // Dark Mode
  static const Color darkPrimary = Color(0xFF9DBFFF);
  static const Color darkOnPrimary = Color(0xFF00337A);
  static const Color darkBackground = Color(0xFF0A0A0F);
  static const Color darkSurface = Color(0xFF0A0A0F);
  static const Color darkPrimaryText = Color(0xFFE4E4E8);
  static const Color darkSecondaryText = Color(0xFFC6C6D0);
  static const Color darkDivider = Color(0xFF44444F);
  static const Color darkSuccess = Color(0xFF4ADE80);
  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkHint = Color(0xFF8F8F99);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightPrimaryText,
      error: AppColors.lightError,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkPrimaryText,
      error: AppColors.darkError,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
