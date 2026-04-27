import 'package:get/get.dart';
import '../views/register_view.dart';
import '../views/home_view.dart';
import '../views/profile_view.dart';
import 'app_routes.dart';

import '../controllers/task_controller.dart';
import '../controllers/profile_controller.dart';

class AppPages {
  static final initial = Routes.register;

  static final routes = [
    // 🔥 REGISTER
    GetPage(
      name: Routes.register,
      page: () => RegisterView(),
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      }),
    ),

    // 🔥 HOME
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: BindingsBuilder(() {
        Get.put(TaskController());
        Get.put(ProfileController());
      }),
    ),

    // 🔥 PROFILE
    GetPage(
      name: Routes.profile,
      page: () => ProfileView(),
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      }),
    ),
  ];
}
