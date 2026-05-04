import 'package:get/get.dart';
import '../views/main_screen.dart';
import '../controllers/task_controller.dart';
import '../views/profile_view.dart';
import '../views/register_view.dart';
import '../routes/app_routes.dart';
import '../views/calendar_view.dart';

class AppPages {
  static final initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const MainScreen(),
      binding: BindingsBuilder(() {
        Get.put(TaskController(), permanent: true);
      }),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileView(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
    ),
    GetPage(
      name: Routes.calendar,
      page: () => const CalendarView(),
    ),
  ];
}
