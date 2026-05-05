import 'package:get/get.dart';

import '../views/main_screen.dart';
import '../views/profile_view.dart';
import '../views/register_view.dart';
import '../views/calendar_view.dart';

import '../routes/app_routes.dart';

import '../binding/home_binding.dart';
import '../binding/profile_binding.dart';
import '../binding/register_binding.dart';
import '../binding/calendar_binding.dart';

class AppPages {
  static final initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const MainScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.calendar,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
  ];
}
