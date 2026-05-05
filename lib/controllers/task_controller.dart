import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/widgets/custom_date_picker.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;

  // ✅ ADDED: current user
  String currentUser = "";

  @override
  void onInit() {
    super.onInit();
  }

  // =========================
  // ✅ SET USER (CALL AFTER LOGIN)
  // =========================
  void setUser(String username) {
    currentUser = username;
    loadTasks();
  }

  // =========================
  // ✅ LOGOUT (ADDED)
  // =========================
  void logout() {
    currentUser = "";
    tasks.clear(); // clear UI only (NOT storage)
  }

  // =========================
  // LOAD TASKS (UPDATED)
  // =========================
  void loadTasks() async {
    if (currentUser.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("tasks_$currentUser");

    if (data != null) {
      final List decoded = jsonDecode(data);

      tasks.clear();
      tasks.addAll(
        decoded.map((e) => TaskModel.fromJson(e)).toList(),
      );
    } else {
      tasks.clear(); // new user → empty
    }
  }

  // =========================
  // SAVE TASKS (UPDATED)
  // =========================
  void saveTasks() async {
    if (currentUser.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "tasks_$currentUser",
      jsonEncode(tasks.map((e) => e.toJson()).toList()),
    );
  }

  // =========================
  // ADD TASK
  // =========================
  void addTask(String title, String date, String category) {
    tasks.add(
      TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        date: date,
        category: category,
        isDone: false,
      ),
    );
    saveTasks();
  }

  // =========================
  // TOGGLE COMPLETE
  // =========================
  void toggleTask(String id) {
    final index = tasks.indexWhere((t) => t.id == id);

    if (index != -1) {
      tasks[index].isDone = !tasks[index].isDone;
      tasks.refresh();
      saveTasks();
    }
  }

  // =========================
  // DELETE
  // =========================
  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    saveTasks();
  }

  // =========================
  // UPDATE TASK
  // =========================
  void updateTask(
    String id,
    String newTitle,
    String newCategory,
    String newDate,
  ) {
    final index = tasks.indexWhere((t) => t.id == id);

    if (index != -1) {
      tasks[index].title = newTitle;
      tasks[index].category = newCategory;
      tasks[index].date = newDate;

      tasks.refresh();
      saveTasks();
    }
  }

  // =========================
  // FILTER
  // =========================
  List<TaskModel> getTasksForDate(String date) {
    return tasks.where((t) => t.date == date).toList();
  }

  // =========================
  // OPEN EDIT TASK
  // =========================
  void openEditTask(TaskModel task) {
    final titleController = TextEditingController(text: task.title);
    final categoryController = TextEditingController(text: task.category);

    String selectedDate = task.date;

    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Edit Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date: $selectedDate"),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await customDatePicker(
                      Get.context!,
                      DateTime.now(),
                      disablePast: true,
                    );

                    if (picked != null) {
                      selectedDate =
                          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

                      update();
                    }
                  },
                  child: const Text("Change Date"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  updateTask(
                    task.id,
                    titleController.text,
                    categoryController.text,
                    selectedDate,
                  );

                  Get.back();
                },
                child: const Text("Save changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
