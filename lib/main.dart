import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/task_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/avatar_controller.dart';

import 'routes/app_pages.dart';

void main() {
  Get.put(TaskController(), permanent: true);
  Get.put(AuthController(), permanent: true);
  Get.put(ProfileController(), permanent: true);
  Get.put(AvatarController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
