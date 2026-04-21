import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/task_model.dart';

class StorageService {
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('user');
    if (data != null) {
      return UserModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', jsonEncode(tasks.map((e) => e.toJson()).toList()));
  }

  Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    if (data != null) {
      return (jsonDecode(data) as List)
          .map((e) => TaskModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
