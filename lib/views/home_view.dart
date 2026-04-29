import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../controllers/avatar_controller.dart';

import '../widgets/task_tile.dart';
import '../widgets/section_title.dart';
import '../core/theme.dart';
import '../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.find<TaskController>();
  final avatarController = Get.find<AvatarController>();

  String formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HEADER
        Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          decoration: const BoxDecoration(
            gradient: AppTheme.gradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Tasks",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              // ✅ FIXED NAVIGATION TO PROFILE
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.profile);
                },
                child: Obx(() {
                  return CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(
                      avatarController
                          .avatars[avatarController.selectedAvatar.value],
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),

        // TASK LIST
        Expanded(
          child: Obx(() {
            final today = DateTime.now();
            final tomorrow = today.add(const Duration(days: 1));

            final todayTasks = controller.getTasksForDate(formatDate(today));
            final tomorrowTasks =
                controller.getTasksForDate(formatDate(tomorrow));

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionTitle("Today"),
                ...todayTasks.map((t) {
                  return GestureDetector(
                    onTap: () => controller.toggleTask(t.id),
                    child: TaskTile(
                      t.title,
                      [t.category],
                      isDone: t.isDone,
                    ),
                  );
                }),
                const SectionTitle("Tomorrow"),
                ...tomorrowTasks.map((t) {
                  return GestureDetector(
                    onTap: () => controller.toggleTask(t.id),
                    child: TaskTile(
                      t.title,
                      [t.category],
                      isDone: t.isDone,
                    ),
                  );
                }),
                const SectionTitle("All Tasks"),
                ...controller.tasks.map((t) {
                  return GestureDetector(
                    onTap: () => controller.toggleTask(t.id),
                    child: TaskTile(
                      t.title,
                      [t.category],
                      isDone: t.isDone,
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
