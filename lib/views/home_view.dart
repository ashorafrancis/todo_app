import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../controllers/avatar_controller.dart';
import '../core/theme.dart';
import '../views/profile_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TaskController controller = Get.find<TaskController>();
  final AvatarController avatarController = Get.find<AvatarController>();

  String formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HEADER (UNCHANGED)
        Container(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
          decoration: const BoxDecoration(
            gradient: AppTheme.gradient,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Tasks",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => ProfileView()),
                child: Obx(() {
                  final index = avatarController.selectedAvatar.value;

                  return CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(
                      avatarController.avatars[
                          index.clamp(0, avatarController.avatars.length - 1)],
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // BODY (ONLY ALL TASKS)
        Expanded(
          child: Obx(() {
            final allTasks = controller.tasks;

            // completed tasks go bottom
            final sortedTasks = [...allTasks];
            sortedTasks.sort((a, b) {
              if (a.isDone == b.isDone) return 0;
              return a.isDone ? 1 : -1;
            });

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "All Tasks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...sortedTasks.map((t) {
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),

                    title: Text(
                      t.title,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: t.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: t.isDone ? Colors.grey : Colors.black,
                      ),
                    ),

                    subtitle: Text(
                      t.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: t.isDone ? Colors.grey.shade400 : Colors.grey,
                      ),
                    ),

                    onTap: () => controller.toggleTask(t.id),

                    // ✅ 3 DOT MENU (REPLACED EDIT/DELETE)
                    trailing: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 18),
                      onSelected: (value) {
                        if (value == "edit") {
                          controller.openEditTask(t);
                        } else if (value == "delete") {
                          controller.deleteTask(t.id);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "edit",
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18, color: Colors.blue),
                              SizedBox(width: 8),
                              Text("Edit"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text("Delete"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          }),
        ),
      ],
    );
  }
}
