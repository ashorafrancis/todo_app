import 'package:get/get.dart';

import '../views/register_view.dart';
import '../views/home_view.dart';
import '../views/profile_view.dart';

import '../controllers/auth_controller.dart';
import '../controllers/task_controller.dart';
import '../controllers/profile_controller.dart';

import 'app_routes.dart';

class AppPages {
  static final initial = Routes.register;

  static final routes = [
    GetPage(
      name: Routes.register,
      page: () => RegisterView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
        Get.put(ProfileController(), permanent: true);
      }),
    ),

    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: BindingsBuilder(() {
        Get.put(TaskController(), permanent: true);
      }),
    ),

    GetPage(name: Routes.profile, page: () => ProfileView()),
  ];
}
