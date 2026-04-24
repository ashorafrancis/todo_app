import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final storage = StorageService();
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    checkUser();
  }

  void checkUser() async {
    user.value = await storage.getUser();
    if (user.value != null) {
      Get.offAllNamed(Routes.home);
    }
  }

  void register(String name, String age, String dob) async {
    if (name.isEmpty || age.isEmpty || dob.isEmpty) {
      Get.snackbar("Error", "Fill all fields");
      return;
    }

    final newUser = UserModel(name: name, age: age, dob: dob);
    await storage.saveUser(newUser);
    user.value = newUser;

    Get.offAllNamed(Routes.home);
  }

  // ✅ NEW FIX
  void updateUser(String name, String age, String dob) async {
    if (name.isEmpty || age.isEmpty || dob.isEmpty) {
      Get.snackbar("Error", "Fill all fields");
      return;
    }

    final updatedUser = UserModel(name: name, age: age, dob: dob);
    await storage.saveUser(updatedUser);

    user.value = updatedUser;

    Get.snackbar("Success", "Profile Updated");
  }

  void logout() async {
    await storage.clear();
    Get.offAllNamed(Routes.register);
  }
}
