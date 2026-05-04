import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime selectedDate = DateTime.now();
  final controller = Get.find<TaskController>();

  String formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
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
            child: Text(
              "Selected: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              final tasks =
                  controller.getTasksForDate(formatDate(selectedDate));

              if (tasks.isEmpty) {
                return const Center(child: Text("No Tasks"));
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, index) {
                  final task = tasks[index];

                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(task.date),
                    trailing: Icon(
                      task.isDone ? Icons.check_circle : Icons.circle_outlined,
                    ),
                    onTap: () => controller.toggleTask(task.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
