import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRegistered = StorageService.isRegistered();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isRegistered ? const HomePage() : const RegisterPage(),
    );
  }
}
