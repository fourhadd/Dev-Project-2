// core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color primary = Color(0xFF3F51B5);
  static const Color primaryLight = Color(0xFFE8EAF6);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F3F7);

  static const Color textPrimary = Color(0xFF1B1B1F);
  static const Color textSecondary = Color(0xFF757575);
  static const Color disabled = Color(0xFF9E9E9E);

  static const Color danger = Color(0xFFD32F2F);
  static const Color white = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);

  static const Color chipSelectedBg = primary;
  static const Color chipSelectedText = white;
  static const Color chipUnselectedBg = Color(0xFFF0F0F0);
  static const Color chipUnselectedText = textPrimary;
}
