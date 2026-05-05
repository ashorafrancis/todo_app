import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../controllers/avatar_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController(), fenix: true);
    Get.lazyPut<AvatarController>(() => AvatarController(), fenix: true);
  }
}
