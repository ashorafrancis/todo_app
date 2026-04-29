import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../controllers/avatar_controller.dart';
import '../widgets/task_tile.dart';
import '../widgets/section_title.dart';
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
        // HEADER
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

        // BODY
        Expanded(
          child: Obx(() {
            final today = DateTime.now();
            final tomorrow = today.add(const Duration(days: 1));

            final todayTasks = controller.getTasksForDate(formatDate(today));
            final tomorrowTasks =
                controller.getTasksForDate(formatDate(tomorrow));
            final allTasks = controller.tasks;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (todayTasks.isNotEmpty) ...[
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
                  }).toList(),
                ],
                const SizedBox(height: 10),
                if (tomorrowTasks.isNotEmpty) ...[
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
                  }).toList(),
                ],
                const SizedBox(height: 10),
                const SectionTitle("All Tasks"),
                ...allTasks.map((t) {
                  return GestureDetector(
                    onTap: () => controller.toggleTask(t.id),
                    child: TaskTile(
                      t.title,
                      [t.category],
                      isDone: t.isDone,
                    ),
                  );
                }).toList(),
              ],
            );
          }),
        ),
      ],
    );
  }
}
