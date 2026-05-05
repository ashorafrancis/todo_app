import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../controllers/avatar_controller.dart';
import '../controllers/auth_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());

    // ✅ ensure dependencies exist
    Get.lazyPut<AvatarController>(() => AvatarController(), fenix: true);
    Get.find<AuthController>(); // already in InitialBinding
  }
}
