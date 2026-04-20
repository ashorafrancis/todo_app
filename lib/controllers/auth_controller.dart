import '../services/storage_service.dart';

class AuthController {
  static Future<void> register({
    required String name,
    required String age,
    required String dob,
  }) async {
    await StorageService.saveUser(name: name, age: age, dob: dob);
  }

  static Future<Map<String, String?>> getUser() async {
    return await StorageService.getUser();
  }

  static Future<void> logout() async {
    await StorageService.clearUser();
  }
}
