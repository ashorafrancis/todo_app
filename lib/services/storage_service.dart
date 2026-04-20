import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/task_model.dart';
import 'dart:convert';

class StorageService {
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool isRegistered() {
    return prefs.getBool('registered') ?? false;
  }

  static void saveUser(UserModel user) {
    prefs.setString('user', jsonEncode(user.toJson()));
    prefs.setBool('registered', true);
  }

  static UserModel? getUser() {
    String? data = prefs.getString('user');
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  static void saveTasks(List<TaskModel> tasks) {
    prefs.setString('tasks', TaskModel.encode(tasks));
  }

  static List<TaskModel> getTasks() {
    String? data = prefs.getString('tasks');
    if (data == null) return [];
    return TaskModel.decode(data);
  }

  static void logout() {
    prefs.clear();
  }
}
