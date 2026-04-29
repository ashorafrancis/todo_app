import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFF2563EB); // blue
  static const secondary = Color(0xFF60A5FA); // light blue
  static const bg = Color(0xFFF4F8FF);

  static const gradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
