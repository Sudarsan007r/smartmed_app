import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get vibrantTheme {
    final baseTextTheme = ThemeData.light().textTheme;
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF009688), // Teal
        primary: const Color(0xFF00796B),   // Dark Teal
        secondary: const Color(0xFFFF7043), // Coral/Salmon Accent
        surface: const Color(0xFFF5F7FA),   // Soft Blue-Grey Background
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      
      textTheme: baseTextTheme.copyWith(
        displayLarge: const TextStyle(
          fontSize: 36, 
          fontWeight: FontWeight.bold,
          color: const Color(0xFF263238), // Blue Grey 900
        ),
        displayMedium: const TextStyle(
          fontSize: 28, 
          fontWeight: FontWeight.w600,
          color: const Color(0xFF37474F),
        ),
        titleLarge: const TextStyle(
          fontSize: 22, 
          fontWeight: FontWeight.w600,
          color: const Color(0xFF455A64),
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 20, // Large readable body
          height: 1.5,
          color: const Color(0xFF455A64),
        ),
        labelLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      
      // Modern Card Theme
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 20),
      ),
      
      // Modern Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFF009688), // Teal
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          elevation: 4,
          shadowColor: Color(0xFF009688).withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
