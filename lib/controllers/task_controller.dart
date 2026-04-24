import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    loadTasks();
    super.onInit();
  }

  void addTask(String title, String date) {
    tasks.add(TaskModel(title: title, date: date));
    saveTasks();
  }

  void editTask(int index, String title, String date) {
    tasks[index].title = title;
    tasks[index].date = date;
    tasks.refresh();
    saveTasks();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasks();
  }

  // ✅ NEW
  void toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    tasks.refresh();
    saveTasks();
  }

  // STORAGE
  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = tasks.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList("tasks", data);
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("tasks");

    if (data != null) {
      tasks.value = data.map((e) => TaskModel.fromJson(jsonDecode(e))).toList();
    }
  }
}
