import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'controllers/auth_controller.dart';

void main() {
  // 🔥 GLOBAL CONTROLLER (VERY IMPORTANT)
  Get.put(AuthController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo App",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
