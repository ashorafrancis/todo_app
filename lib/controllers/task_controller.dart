import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  // ✅ ADD TASK
  void addTask(String title, String date) {
    tasks.add(TaskModel(title: title, date: date));
    saveTasks();
  }

  // ✅ EDIT TASK
  void editTask(int index, String title, String date) {
    tasks[index].title = title;
    tasks[index].date = date;
    tasks.refresh();
    saveTasks();
  }

  // ✅ DELETE TASK
  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasks();
  }

  // ✅ TOGGLE DONE
  void toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    tasks.refresh();
    saveTasks();
  }

  // ✅ SAVE TASKS
  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = tasks.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList("tasks", data);
  }

  // ✅ LOAD TASKS
  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("tasks");

    if (data != null) {
      tasks.value = data.map((e) => TaskModel.fromJson(jsonDecode(e))).toList();
    }
  }

  // 🔥 FULL FIXED DIALOG
  void openTaskDialog({int? index}) {
    final taskCtrl = TextEditingController();
    final dateCtrl = TextEditingController();

    if (index != null) {
      taskCtrl.text = tasks[index].title;
      dateCtrl.text = tasks[index].date;
    }

    // ✅ DATE PICKER
    Future<void> pickDate() async {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: today,
        firstDate: today, // ❌ BLOCK PAST
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        dateCtrl.text = picked.toString().split(" ")[0];
      }
    }

    // ✅ DIALOG UI FIXED
    Get.defaultDialog(
      title: index == null ? "Add Task" : "Edit Task",
      backgroundColor: Colors.white,
      radius: 20,

      content: Column(
        children: [
          TextField(
            controller: taskCtrl,
            decoration: InputDecoration(
              labelText: "Task Title",
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.task, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: dateCtrl,
            readOnly: true,
            onTap: pickDate,
            decoration: InputDecoration(
              labelText: "Due Date",
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),

      textConfirm: "Save",
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF6C63FF),

      onConfirm: () {
        if (taskCtrl.text.isEmpty || dateCtrl.text.isEmpty) {
          Get.snackbar("Error", "Fill all fields");
          return;
        }

        // ✅ DATE VALIDATION
        DateTime selected = DateTime.parse(dateCtrl.text);
        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);

        if (selected.isBefore(today)) {
          Get.snackbar("Error", "Cannot select past date");
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
