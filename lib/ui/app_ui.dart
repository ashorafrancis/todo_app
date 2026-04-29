import 'package:flutter/material.dart';

class AppUI {
  // COLORS (refined modern palette)
  static const bg = Color(0xFFF8F9FD);
  static const surface = Colors.white;
  static const primary = Color(0xFF7C3AED);
  static const primaryLight = Color(0xFFEDE9FE);
  static const accent = Color(0xFF10B981);
  static const danger = Color(0xFFEF4444);
  static const textDark = Color(0xFF1F2937);
  static const textMuted = Color(0xFF6B7280);

  // GRADIENTS
  static const headerGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF9333EA), Color(0xFFC026D3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // TEXT STYLES
  static const headingLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.5,
  );

  static const headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const subtitle = TextStyle(
    fontSize: 13,
    color: textMuted,
    fontWeight: FontWeight.w400,
  );

  static const buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  // CARD STYLE
  static BoxDecoration card = BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF7C3AED).withOpacity(0.08),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // INPUT DECORATION
  static InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: textMuted,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: primary, size: 22),
      filled: true,
      fillColor: const Color(0xFFF3F4F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }
}
