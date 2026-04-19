import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> registerUser({
    required String name,
    required String age,
    required String dob,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("user_name", name);
    await prefs.setString("user_age", age);
    await prefs.setString("user_dob", dob);
  }
}
