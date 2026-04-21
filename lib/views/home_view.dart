import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  final controller = Get.find<TaskController>();

  // ADD / EDIT TASK DIALOG
  void openTaskDialog({int? index}) {
    final taskCtrl = TextEditingController();
    final dateCtrl = TextEditingController();

    if (index != null) {
      taskCtrl.text = controller.tasks[index].title;
      dateCtrl.text = controller.tasks[index].date;
    }

    Future<void> pickDate() async {
      DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
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
          const SizedBox(height: 10),
          TextField(
            controller: dateCtrl,
            readOnly: true,
            onTap: pickDate,
            decoration: const InputDecoration(labelText: "Due Date"),
          ),
        ],
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      onConfirm: () {
        if (taskCtrl.text.isEmpty || dateCtrl.text.isEmpty) {
          Get.snackbar("Error", "Fill all fields");
          return;
        }

        if (index == null) {
          controller.addTask(taskCtrl.text, dateCtrl.text);
        } else {
          controller.editTask(index, taskCtrl.text, dateCtrl.text);
        }

        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      body: Column(
        children: [
          // 🔥 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5F2EEA), Color(0xFF8E2DE2)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello 👋",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white),
                      onPressed: () => Get.toNamed(Routes.profile),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  "Your Tasks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => Text(
                    "${controller.tasks.length} Tasks",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),

          // 📋 TASK LIST
          Expanded(
            child: Obx(() {
              if (controller.tasks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.task_alt, size: 60, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "No tasks yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.tasks.length,
                itemBuilder: (_, i) {
                  final task = controller.tasks[i];

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: task.isDone ? Colors.green[50] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Row(
                      children: [
                        // ✅ CHECKBOX
                        Checkbox(
                          value: task.isDone,
                          onChanged: (_) => controller.toggleTask(i),
                          activeColor: Colors.green,
                        ),

                        const SizedBox(width: 8),

                        // TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Due: ${task.date}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ACTIONS
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => openTaskDialog(index: i),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => controller.deleteTask(i),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),

      // ➕ ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5F2EEA),
        onPressed: () => openTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
