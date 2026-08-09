import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Palette (Deep Teal & Vibrant Cyan)
  static const Color primary = Color(0xFF0F766E); // Deep Teal
  static const Color primaryLight = Color(0xFF14B8A6); // Teal Light
  static const Color primaryDark = Color(0xFF115E59); // Deep Emerald

  // Accent & Highlights
  static const Color accent = Color(0xFFF97316); // Vibrant Coral Orange
  static const Color accentLight = Color(0xFFFFEDD5);

  // Category Colors
  static const Map<String, Color> categoryColors = {
    'Health': Color(0xFFE11D48), // Rose
    'Education': Color(0xFF2563EB), // Royal Blue
    'Emergency': Color(0xFFD97706), // Amber
    'Environment': Color(0xFF059669), // Emerald Green
    'Empowerment': Color(0xFF7C3AED), // Violet
  };

  // Background & Neutral Light Mode
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Background & Neutral Dark Mode
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color borderDark = Color(0xFF334155);

  // Status Colors
  static const Color favoriteRed = Color(0xFFEF4444);
}
