import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/task_controller.dart';
import '../routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<TaskController>();

  int selectedAvatar = 0;

  final List<IconData> avatars = [
    Icons.person,
    Icons.person_2,
    Icons.person_3,
    Icons.face,
    Icons.sentiment_satisfied,
    Icons.tag_faces,
  ];

  @override
  void initState() {
    super.initState();
    loadAvatar();
  }

  Future<void> loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAvatar = prefs.getInt("avatar") ?? 0;
    });
  }

  // 🔥 RESTORED ADD / EDIT TASK DIALOG (THIS WAS MISSING)
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
    final avatarsList = avatars;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      body: Column(
        children: [
          // 🔥 HEADER (ONLY AVATAR UPDATED)
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

                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.profile),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          avatarsList[selectedAvatar],
                          color: const Color(0xFF5F2EEA),
                        ),
                      ),
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

          // 📋 TASK LIST (UNCHANGED)
          Expanded(
            child: Obx(() {
              if (controller.tasks.isEmpty) {
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
                itemCount: controller.tasks.length,
                itemBuilder: (_, i) {
                  final task = controller.tasks[i];

                  return Container(
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
                        Checkbox(
                          value: task.isDone,
                          onChanged: (_) => controller.toggleTask(i),
                          activeColor: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task.title),
                              Text("Due: ${task.date}"),
                            ],
                          ),
                        ),
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
                  );
                },
              );
            }),
          ),
        ],
      ),

      // 🔥 FIXED BUTTON (THIS WAS BROKEN)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5F2EEA),
        onPressed: () => openTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
