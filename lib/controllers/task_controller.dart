import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import 'auth_controller.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  final auth = Get.find<AuthController>();

  String get key {
    final name = auth.user.value?.name ?? "guest";
    return "tasks_$name";
  }

  @override
  void onInit() {
    super.onInit();

    ever(auth.user, (_) {
      loadTasks(); // reload when user changes
    });

    loadTasks();
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

  void toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    tasks.refresh();
    saveTasks();
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(key, data);
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList(key);

    if (data != null) {
      tasks.value = data.map((e) => TaskModel.fromJson(jsonDecode(e))).toList();
    } else {
      tasks.clear();
    }
  }

  void openTaskDialog({int? index}) {
    final taskCtrl = TextEditingController();
    final dateCtrl = TextEditingController();

    if (index != null) {
      taskCtrl.text = tasks[index].title;
      dateCtrl.text = tasks[index].date;
    }

    Future<void> pickDate() async {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: today,
        firstDate: today,
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        dateCtrl.text = picked.toString().split(" ")[0];
      }
    }

    Get.defaultDialog(
      title: index == null ? "Add Task" : "Edit Task",
      content: Column(
        children: [
          TextField(
            controller: taskCtrl,
            decoration: const InputDecoration(labelText: "Task Title"),
          ),
          TextField(
            controller: dateCtrl,
            readOnly: true,
            onTap: pickDate,
            decoration: const InputDecoration(labelText: "Due Date"),
          ),
        ],
      ),
      textConfirm: "Save",
      onConfirm: () {
        if (taskCtrl.text.isEmpty || dateCtrl.text.isEmpty) {
          Get.snackbar("Error", "Fill all fields");
          return;
        }

        if (index == null) {
          addTask(taskCtrl.text, dateCtrl.text);
        } else {
          editTask(index, taskCtrl.text, dateCtrl.text);
        }

        Get.back();
      },
    );
  }
}
