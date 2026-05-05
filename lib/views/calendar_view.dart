import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../core/theme.dart';
import '../controllers/avatar_controller.dart';
import '../views/profile_view.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime selectedDate = DateTime.now();
  final controller = Get.find<TaskController>();
  final avatarController = Get.find<AvatarController>();

  String formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/home');
        return false;
      },
      child: Column(
        children: [
          // ✅ SAME HEADER STYLE AS HOME
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Calendar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat("MMMM d, yyyy").format(selectedDate),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.to(() => ProfileView()),
                  child: Obx(() {
                    final index = avatarController.selectedAvatar.value;

                    return CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(
                        avatarController.avatars[index.clamp(
                            0, avatarController.avatars.length - 1)],
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ✅ DATE SELECT BUTTON (STYLED)
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (picked != null) {
                setState(() => selectedDate = picked);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat("MMMM d, yyyy").format(selectedDate),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 14, color: Colors.grey),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ✅ TASK LIST (MATCH HOME STYLE)
          Expanded(
            child: Obx(() {
              final tasks =
                  controller.getTasksForDate(formatDate(selectedDate));

              if (tasks.isEmpty) {
                return const Center(child: Text("No Tasks"));
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: tasks.map((task) {
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),

                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isDone ? Colors.grey : Colors.black,
                      ),
                    ),

                    // ✅ SAME STYLE AS HOME
                    subtitle: Text(
                      task.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: task.isDone ? Colors.grey.shade400 : Colors.grey,
                      ),
                    ),

                    onTap: () => controller.toggleTask(task.id),
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
