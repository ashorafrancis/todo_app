import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/task_controller.dart';
import '../controllers/avatar_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ ORDER MATTERS

    Get.put(TaskController(), permanent: true);
    Get.put(AvatarController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
