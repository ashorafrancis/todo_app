import 'package:flutter/material.dart';

class AppTheme {
  // COLORS
  static const primary = Color(0xFF2563EB);
  static const secondary = Color(0xFF60A5FA);
  static const bg = Color(0xFFF8F9FD);
  static const surface = Colors.white;

  static const textDark = Color(0xFF1F2937);
  static const textMuted = Color(0xFF6B7280);

  static const success = Color(0xFF22C55E);
  static const danger = Color(0xFFEF4444);

  // GRADIENT
  static const gradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // TEXT STYLES
  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const subtitle = TextStyle(
    fontSize: 13,
    color: textMuted,
  );
}
