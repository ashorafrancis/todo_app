import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../routes/app_routes.dart';
import '../ui/app_ui.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUI.bg,

      // HEADER (premium gradient)
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 25,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Tasks",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Stay organized",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),

                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white),
                  onPressed: () => Get.toNamed(Routes.profile),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // TASK LIST
          Expanded(
            child: Obx(() {
              if (taskController.tasks.isEmpty) {
                return const Center(child: Text("No tasks yet"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.tasks[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: AppUI.card,

                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => taskController.toggleTask(index),
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: task.isDone
                                  ? AppUI.primary
                                  : Colors.transparent,
                              border: Border.all(color: AppUI.primary),
                            ),
                            child: task.isDone
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task.title, style: AppUI.title),

                              const SizedBox(height: 4),

                              Text(task.date, style: AppUI.subtitle),
                            ],
                          ),
                        ),

                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              child: const Text("Edit"),
                              onTap: () {
                                Future.delayed(Duration.zero, () {
                                  taskController.openTaskDialog(index: index);
                                });
                              },
                            ),
                            PopupMenuItem(
                              child: const Text("Delete"),
                              onTap: () {
                                Future.delayed(Duration.zero, () {
                                  taskController.deleteTask(index);
                                });
                              },
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

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppUI.primary,
        foregroundColor: Colors.white,
        onPressed: () => taskController.openTaskDialog(),
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
      ),
    );
  }
}
