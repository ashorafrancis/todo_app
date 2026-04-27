import 'package:flutter/material.dart';

class AppUI {
  // COLORS (premium minimal palette)
  static const bg = Color(0xFFF4F6FB);
  static const surface = Colors.white;
  static const primary = Color(0xFF6C5CE7);
  static const accent = Color(0xFF00B894);
  static const danger = Color(0xFFEF4444);

  // TEXT
  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const subtitle = TextStyle(fontSize: 13, color: Colors.grey);

  // CARD STYLE (VERY IMPORTANT FOR PRO LOOK)
  static BoxDecoration card = BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
