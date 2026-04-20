import 'package:flutter/material.dart';
import 'views/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

/* ---------------- APP ROOT ---------------- */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
