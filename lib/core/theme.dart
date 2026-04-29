import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFF7B61FF);
  static const secondary = Color(0xFFFF6FD8);
  static const bg = Color(0xFFF4F5F7);

  static const gradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
