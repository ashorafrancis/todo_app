import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'binding/initial_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ ONLY ONE PLACE FOR CONTROLLERS
      initialBinding: InitialBinding(),

      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
