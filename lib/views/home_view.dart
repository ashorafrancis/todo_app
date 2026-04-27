import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/task_controller.dart';
import '../controllers/profile_controller.dart';
import '../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  final task = Get.find<TaskController>();
  final profile = Get.find<ProfileController>();

  String getTodayDate() {
    final now = DateTime.now();
    return DateFormat("EEEE, MMM d").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: Column(
        children: [
          // 🔥 HEADER WITH PROFILE ICON
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF8E2DE2)],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 TOP ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello 👋",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          getTodayDate(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // ✅ PROFILE NAVIGATION BACK
                    Obx(
                      () => GestureDetector(
                        onTap: () => Get.toNamed(Routes.profile),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            profile.avatars[profile.selectedAvatar.value],
                            color: const Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                const Text(
                  "Your Tasks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Obx(
                  () => Text(
                    "${task.tasks.length} Tasks",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),

          // 🔥 TASK LIST (FULL FEATURES RESTORED)
          Expanded(
            child: Obx(() {
              if (task.tasks.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.task_alt, size: 60, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("No tasks yet"),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: task.tasks.length,
                itemBuilder: (_, i) {
                  final t = task.tasks[i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: t.isDone ? Colors.green[50] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: t.isDone,
                          onChanged: (_) => task.toggleTask(i),
                          activeColor: Colors.green,
                        ),

                        const SizedBox(width: 8),

                        // 🔹 TASK DETAILS
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  decoration: t.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              Text(
                                "Due: ${t.date}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ✅ EDIT BUTTON BACK
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => task.openTaskDialog(index: i),
                        ),

                        // ✅ DELETE BUTTON BACK
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => task.deleteTask(i),
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

      // ✅ ADD BUTTON (UNCHANGED)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C63FF),
        onPressed: () => task.openTaskDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
